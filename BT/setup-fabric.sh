#!/usr/bin/env bash

# Modern Hyperledger Fabric Practical 5
# Target: Ubuntu/Linux Mint with Docker and sudo access.

set -Eeuo pipefail
IFS=$'\n\t'

FABRIC_VERSION="${FABRIC_VERSION:-2.5.16}"
CA_VERSION="${CA_VERSION:-1.5.17}"
CC_NAME="${CC_NAME:-studentregistry}"
CHANNEL_NAME="${CHANNEL_NAME:-mychannel}"
WORK_DIR="${FABRIC_WORK_DIR:-$HOME/fabric-practical-5}"
SAMPLES_DIR="$WORK_DIR/fabric-samples"
CC_DIR="$WORK_DIR/chaincode/studentregistry"
LOG_DIR="$WORK_DIR/logs"
RUN_ID="$(date +%Y%m%d-%H%M%S)"
LOG_FILE="$LOG_DIR/run-$RUN_ID.log"
COMMAND_FILE="$LOG_DIR/commands-$RUN_ID.log"

mkdir -p "$LOG_DIR"
touch "$COMMAND_FILE"
exec > >(tee -a "$LOG_FILE") 2>&1
export PS4='+ ${BASH_SOURCE##*/}:${LINENO}: '
set -x

record_command() {
    printf '%s\n' "$*" >> "$COMMAND_FILE"
}

run() {
    record_command "$*"
    "$@"
}

fail() {
    printf '\nERROR: %s\n' "$*" >&2
    printf 'Full log: %s\n' "$LOG_FILE" >&2
    exit 1
}

cleanup_on_error() {
    local status=$?
    if [[ $status -ne 0 ]]; then
        printf '\nThe setup stopped with exit code %s.\n' "$status" >&2
        printf 'Full log: %s\n' "$LOG_FILE" >&2
        printf 'Command log: %s\n' "$COMMAND_FILE" >&2
    fi
}
trap cleanup_on_error EXIT

usage() {
    cat <<'EOF'
Usage:
  ./setup-fabric.sh          Install prerequisites, start Fabric, deploy, and test.
  ./setup-fabric.sh status   Show the Fabric Docker containers.
  ./setup-fabric.sh down     Stop the Fabric test network.
  ./setup-fabric.sh clean    Stop the network and remove this practical's generated data.
  ./setup-fabric.sh help     Show this help.

Environment overrides:
  FABRIC_VERSION=2.5.16
  CA_VERSION=1.5.17
  FABRIC_WORK_DIR=$HOME/fabric-practical-5
EOF
}

require_command() {
    command -v "$1" >/dev/null 2>&1 || fail "Required command not found: $1"
}

detect_os() {
    [[ -r /etc/os-release ]] || fail "This script requires Ubuntu or Linux Mint."
    # shellcheck disable=SC1091
    source /etc/os-release
    case "${ID:-}" in
        ubuntu|linuxmint)
            ;;
        *)
            case "${ID_LIKE:-}" in
                *ubuntu*|*debian*)
                    ;;
                *)
                    fail "Unsupported OS: ${PRETTY_NAME:-unknown}. Use Ubuntu or Linux Mint."
                    ;;
            esac
            ;;
    esac
}

check_resources() {
    local available_kb ram_mb
    available_kb="$(df -Pk "$HOME" | awk 'NR==2 {print $4}')"
    ram_mb="$(awk '/MemTotal/ {printf "%d", $2 / 1024}' /proc/meminfo)"

    (( available_kb >= 20000000 )) ||
        fail "At least 20 GB free disk space is recommended under $HOME."
    (( ram_mb >= 4096 )) ||
        fail "At least 4 GB RAM is required; detected approximately ${ram_mb} MB."
}

install_prerequisites() {
    local compose_package docker_codename docker_arch
    require_command sudo
    run sudo -v
    run sudo apt-get update
    run sudo apt-get install -y ca-certificates curl git jq gnupg

    if apt-cache show docker-compose-v2 >/dev/null 2>&1; then
        compose_package=docker-compose-v2
        run sudo apt-get install -y docker.io "$compose_package"
    elif apt-cache show docker-compose-plugin >/dev/null 2>&1; then
        compose_package=docker-compose-plugin
        run sudo apt-get install -y docker.io "$compose_package"
    else
        # Older Ubuntu/Linux Mint repositories may not contain Compose v2. Use
        # Docker's official Ubuntu repository rather than installing Compose v1.
        # shellcheck disable=SC1091
        source /etc/os-release
        docker_codename="${UBUNTU_CODENAME:-${VERSION_CODENAME:-}}"
        [[ -n "$docker_codename" ]] ||
            fail "Could not determine the Ubuntu base codename for Docker's repository."
        docker_arch="$(dpkg --print-architecture)"
        run sudo install -m 0755 -d /etc/apt/keyrings
        run bash -c "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg"
        run bash -c "echo 'deb [arch=$docker_arch signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $docker_codename stable' | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null"
        run sudo apt-get update
        run sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    fi

    if [[ -d /run/systemd/system ]] && command -v systemctl >/dev/null 2>&1; then
        run sudo systemctl enable --now docker
    elif command -v service >/dev/null 2>&1; then
        run sudo service docker start
    else
        fail "Could not find a supported service manager for Docker."
    fi

    if ! docker info >/dev/null 2>&1; then
        run sudo usermod -aG docker "$USER"
        fail "Docker is installed, but this shell cannot access it. Log out and back in, then rerun the script."
    fi

    require_command curl
    require_command git
    require_command jq
    require_command docker
    run docker compose version
}

install_fabric() {
    local installed_version
    mkdir -p "$WORK_DIR"
    cd "$WORK_DIR"

    if [[ ! -x "$WORK_DIR/install-fabric.sh" ]]; then
        run curl -fsSLo "$WORK_DIR/install-fabric.sh" \
            "https://raw.githubusercontent.com/hyperledger/fabric/v${FABRIC_VERSION}/scripts/install-fabric.sh"
        run chmod +x "$WORK_DIR/install-fabric.sh"
    fi

    if [[ ! -d "$SAMPLES_DIR/test-network" ||
          ! -x "$SAMPLES_DIR/test-network/network.sh" ||
          ! -x "$SAMPLES_DIR/bin/peer" ]]; then
        run "$WORK_DIR/install-fabric.sh" \
            -f "$FABRIC_VERSION" \
            -c "$CA_VERSION" \
            docker binary samples
    fi

    [[ -x "$SAMPLES_DIR/test-network/network.sh" && -x "$SAMPLES_DIR/bin/peer" ]] ||
        fail "Fabric test network was not installed correctly."
    run "$SAMPLES_DIR/bin/peer" version
    installed_version="$("$SAMPLES_DIR/bin/peer" version 2>/dev/null | awk -F': ' '$1 == "Version" {print $2; exit}')"
    [[ "$installed_version" == "$FABRIC_VERSION" ]] ||
        fail "Installed Fabric version '$installed_version' does not match requested '$FABRIC_VERSION'."
}

write_chaincode() {
    mkdir -p "$CC_DIR"

    cat > "$CC_DIR/package.json" <<'EOF'
{
  "name": "student-registry",
  "version": "1.0.0",
  "description": "Native Hyperledger Fabric student registry chaincode",
  "main": "index.js",
  "engines": {
    "node": ">=16",
    "npm": ">=8"
  },
  "dependencies": {
    "fabric-contract-api": "__FABRIC_VERSION__",
    "fabric-shim": "__FABRIC_VERSION__"
  }
}
EOF
    sed -i "s/__FABRIC_VERSION__/${FABRIC_VERSION}/g" "$CC_DIR/package.json"

    cat > "$CC_DIR/index.js" <<'EOF'
'use strict';

const { Contract } = require('fabric-contract-api');

class StudentRegistryContract extends Contract {
    async AddStudent(ctx, rollNo, name, course) {
        if (!rollNo || !name || !course) {
            throw new Error('rollNo, name, and course are required');
        }

        const key = `student_${rollNo}`;
        const existing = await ctx.stub.getState(key);
        if (existing && existing.length > 0) {
            throw new Error(`Student ${rollNo} already exists`);
        }

        const student = {
            docType: 'student',
            rollNo,
            name,
            course
        };
        await ctx.stub.putState(key, Buffer.from(JSON.stringify(student)));
        return JSON.stringify(student);
    }

    async ReadStudent(ctx, rollNo) {
        const key = `student_${rollNo}`;
        const data = await ctx.stub.getState(key);
        if (!data || data.length === 0) {
            throw new Error(`Student ${rollNo} does not exist`);
        }
        return data.toString();
    }

    async UpdateStudent(ctx, rollNo, name, course) {
        const key = `student_${rollNo}`;
        const data = await ctx.stub.getState(key);
        if (!data || data.length === 0) {
            throw new Error(`Student ${rollNo} does not exist`);
        }

        const student = {
            docType: 'student',
            rollNo,
            name,
            course
        };
        await ctx.stub.putState(key, Buffer.from(JSON.stringify(student)));
        return JSON.stringify(student);
    }

    async GetAllStudents(ctx) {
        const iterator = await ctx.stub.getStateByRange('student_', 'student_\uffff');
        const students = [];
        let result = await iterator.next();

        while (!result.done) {
            if (result.value && result.value.value.toString()) {
                students.push(JSON.parse(result.value.value.toString('utf8')));
            }
            result = await iterator.next();
        }

        await iterator.close();
        return JSON.stringify(students);
    }
}

module.exports.contracts = [StudentRegistryContract];
EOF
}

docker_network_running() {
    docker ps --format '{{.Names}}' | grep -q '^peer0.org1.example.com$'
}

start_network() {
    cd "$SAMPLES_DIR/test-network"
    if docker_network_running; then
        printf 'Resetting the existing Fabric test network for a clean demonstration.\n'
    fi
    run ./network.sh down
    run ./network.sh up createChannel -ca
}

deploy_chaincode() {
    cd "$SAMPLES_DIR/test-network"
    run ./network.sh deployCC \
        -ccn "$CC_NAME" \
        -ccp "$CC_DIR" \
        -ccl javascript
}

set_org1_environment() {
    export PATH="$SAMPLES_DIR/bin:$PATH"
    export FABRIC_CFG_PATH="$SAMPLES_DIR/config"
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=Org1MSP
    export CORE_PEER_TLS_ROOTCERT_FILE="$SAMPLES_DIR/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt"
    export CORE_PEER_MSPCONFIGPATH="$SAMPLES_DIR/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp"
    export CORE_PEER_ADDRESS=localhost:7051
    export ORDERER_CA="$SAMPLES_DIR/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"
}

invoke() {
    local function_name="$1"
    shift
    local args_json
    args_json="$(printf '%s\n' "$@" | jq -R . | jq -s .)"
    run peer chaincode invoke \
        -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com \
        --tls \
        --cafile "$ORDERER_CA" \
        -C "$CHANNEL_NAME" \
        -n "$CC_NAME" \
        --peerAddresses localhost:7051 \
        --tlsRootCertFiles "$CORE_PEER_TLS_ROOTCERT_FILE" \
        --waitForEvent \
        --waitForEventTimeout 60s \
        -c "{\"function\":\"$function_name\",\"Args\":$args_json}"
}

query() {
    local function_name="$1"
    shift
    local args_json
    args_json="$(printf '%s\n' "$@" | jq -R . | jq -s .)"
    run peer chaincode query \
        -C "$CHANNEL_NAME" \
        -n "$CC_NAME" \
        -c "{\"function\":\"$function_name\",\"Args\":$args_json}"
}

run_demo() {
    set_org1_environment
    printf '\nRunning student registry demonstration...\n'
    invoke AddStudent 101 Alice "Blockchain Technology"
    invoke AddStudent 102 Bob "Computer Engineering"
    query ReadStudent 101
    invoke UpdateStudent 101 "Alice Sharma" "Blockchain Technology"
    query ReadStudent 101
    query GetAllStudents
}

append_history_hint() {
    local history_file="${HISTFILE:-$HOME/.bash_history}"
    {
        printf '# Hyperledger Fabric Practical 5 (%s)\n' "$RUN_ID"
        printf 'cd %q\n' "$WORK_DIR"
        printf 'docker ps\n'
        printf 'cd %q\n' "$SAMPLES_DIR/test-network"
        printf './network.sh status\n'
        printf './network.sh down\n'
    } >> "$history_file" 2>/dev/null || true

    printf '\nCommand log: %s\n' "$COMMAND_FILE"
    printf 'Run `history -r` in this terminal to reload the added history entries.\n'
}

show_status() {
    require_command docker
    docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'
}

stop_network() {
    [[ -x "$SAMPLES_DIR/test-network/network.sh" ]] ||
        fail "Fabric test network is not installed at $SAMPLES_DIR."
    cd "$SAMPLES_DIR/test-network"
    run ./network.sh down
}

clean_generated_data() {
    stop_network
    run rm -rf "$CC_DIR" "$LOG_DIR"
    printf 'Removed generated chaincode and logs. Fabric samples were preserved.\n'
}

main() {
    local action="${1:-setup}"
    case "$action" in
        help|-h|--help)
            usage
            ;;
        status)
            show_status
            ;;
        down)
            stop_network
            ;;
        clean)
            clean_generated_data
            ;;
        setup)
            detect_os
            check_resources
            install_prerequisites
            install_fabric
            write_chaincode
            start_network
            deploy_chaincode
            run_demo
            append_history_hint
            printf '\nPractical 5 setup and demonstration completed successfully.\n'
            printf 'Work directory: %s\n' "$WORK_DIR"
            printf 'Run log: %s\n' "$LOG_FILE"
            ;;
        *)
            usage
            fail "Unknown action: $action"
            ;;
    esac
}

main "$@"
