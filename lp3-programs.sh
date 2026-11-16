#!/usr/bin/env bash

set -Eeuo pipefail

BASE_URL="https://raw.githubusercontent.com/obstinix/lp3/main"
DEFAULT_OUTPUT_DIR="${LP3_OUTPUT_DIR:-LP-3-Programs}"

usage() {
    cat <<'EOF'
LP-3 program downloader

Usage:
  ./lp3-programs.sh help
  ./lp3-programs.sh list
  ./lp3-programs.sh download bt <name>
  ./lp3-programs.sh download daa <name>
  ./lp3-programs.sh download ml <name>
  ./lp3-programs.sh download all

Available BT names:
  simplestorage       SimpleStorage.sol
  bank                Bank.sol
  studentregistry     StudentRegistry.sol
  setup-fabric        setup-fabric.sh

Available DAA names:
  fibonacci           fibonacci.cpp
  huffman             huffman.cpp
  knapsack            knapsack.cpp
  nqueens             nqueens.cpp
  quicksort           quicksort.cpp

Available ML names:
  uber                ML_1_UBER.ipynb
  email-spam          ML_2_EMAIL_SPAM.ipynb
  bank-churn          ML_3_BANK_CHURN.ipynb
  diabetes            ML_5_DIABETES.ipynb
  sales               ML_6_SALES.ipynb

Examples:
  ./lp3-programs.sh list
  ./lp3-programs.sh download bt bank
  ./lp3-programs.sh download daa quicksort
  ./lp3-programs.sh download ml diabetes
  ./lp3-programs.sh download all

The default download folder is ./LP-3-Programs.
Change it with:
  LP3_OUTPUT_DIR=./my-folder ./lp3-programs.sh download daa fibonacci
EOF
}

require_curl() {
    command -v curl >/dev/null 2>&1 ||
        { printf 'ERROR: curl is required. Install it with: sudo apt install curl\n' >&2; exit 1; }
}

download_file() {
    local relative_path="$1"
    local destination="$DEFAULT_OUTPUT_DIR/$relative_path"
    mkdir -p "$(dirname "$destination")"
    printf 'Downloading %s...\n' "$relative_path"
    curl -fL "$BASE_URL/$relative_path" -o "$destination"
    printf 'Saved to %s\n' "$destination"
}

download_bt() {
    case "$1" in
        simplestorage) download_file "BT/SimpleStorage.sol" ;;
        bank) download_file "BT/Bank.sol" ;;
        studentregistry) download_file "BT/StudentRegistry.sol" ;;
        setup-fabric) download_file "BT/setup-fabric.sh" ;;
        *) printf 'ERROR: Unknown BT name: %s\n\n' "$1" >&2; usage; exit 1 ;;
    esac
}

download_daa() {
    case "$1" in
        fibonacci) download_file "DAA/fibonacci.cpp" ;;
        huffman) download_file "DAA/huffman.cpp" ;;
        knapsack) download_file "DAA/knapsack.cpp" ;;
        nqueens) download_file "DAA/nqueens.cpp" ;;
        quicksort) download_file "DAA/quicksort.cpp" ;;
        *) printf 'ERROR: Unknown DAA name: %s\n\n' "$1" >&2; usage; exit 1 ;;
    esac
}

download_ml() {
    case "$1" in
        uber) download_file "ML/ML_1_UBER.ipynb" ;;
        email-spam) download_file "ML/ML_2_EMAIL_SPAM.ipynb" ;;
        bank-churn) download_file "ML/ML_3_BANK_CHURN.ipynb" ;;
        diabetes) download_file "ML/ML_5_DIABETES.ipynb" ;;
        sales) download_file "ML/ML_6_SALES.ipynb" ;;
        *) printf 'ERROR: Unknown ML name: %s\n\n' "$1" >&2; usage; exit 1 ;;
    esac
}

download_all() {
    download_bt simplestorage
    download_bt bank
    download_bt studentregistry
    download_bt setup-fabric
    download_daa fibonacci
    download_daa huffman
    download_daa knapsack
    download_daa nqueens
    download_daa quicksort
    download_ml uber
    download_ml email-spam
    download_ml bank-churn
    download_ml diabetes
    download_ml sales
}

list_files() {
    cat <<'EOF'
BT:
  simplestorage       SimpleStorage.sol
  bank                Bank.sol
  studentregistry     StudentRegistry.sol
  setup-fabric        setup-fabric.sh

DAA:
  fibonacci           fibonacci.cpp
  huffman             huffman.cpp
  knapsack            knapsack.cpp
  nqueens             nqueens.cpp
  quicksort           quicksort.cpp

ML:
  uber                ML_1_UBER.ipynb
  email-spam          ML_2_EMAIL_SPAM.ipynb
  bank-churn          ML_3_BANK_CHURN.ipynb
  diabetes            ML_5_DIABETES.ipynb
  sales               ML_6_SALES.ipynb
EOF
}

main() {
    local action="${1:-help}"

    case "$action" in
        help|-h|--help)
            usage
            ;;
        list)
            list_files
            ;;
        download)
            require_curl
            [[ $# -ge 2 ]] || { usage; exit 1; }
            case "$2" in
                all)
                    download_all
                    ;;
                bt)
                    [[ $# -eq 3 ]] || { usage; exit 1; }
                    download_bt "$3"
                    ;;
                daa)
                    [[ $# -eq 3 ]] || { usage; exit 1; }
                    download_daa "$3"
                    ;;
                ml)
                    [[ $# -eq 3 ]] || { usage; exit 1; }
                    download_ml "$3"
                    ;;
                *)
                    printf 'ERROR: Use bt, daa, ml, or all after download.\n\n' >&2
                    usage
                    exit 1
                    ;;
            esac
            ;;
        *)
            printf 'ERROR: Unknown command: %s\n\n' "$action" >&2
            usage
            exit 1
            ;;
    esac
}

main "$@"
