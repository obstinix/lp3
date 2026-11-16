# Practical 5: Modern Hyperledger Fabric Student Registry

## Aim

Set up a modern Hyperledger Fabric test network and deploy native JavaScript
chaincode for a student registry using one repeatable Bash script.

## Important Status Note

The original Practical 5 used Hyperledger Composer. Composer was deprecated and
archived in 2019. This practical replaces Composer with a maintained Hyperledger
Fabric test network and native Fabric chaincode.

The practical does not use Composer Playground, `.cto` model files, `logic.js`,
`permissions.acl`, or Composer CLI commands.

## Requirements

- Ubuntu or Linux Mint
- Bash
- Internet access
- An account with `sudo` permission
- Docker-compatible system
- At least 4 GB RAM
- At least 20 GB free disk space; 25–40 GB is recommended
- MetaMask is not required for this Fabric practical

The script is intended for Ubuntu/Linux Mint. It is not a Windows Command Prompt
script and should not be run on an 8 GB non-persistent live USB.

## Files

The practical has one executable setup script:

```text
setup-fabric.sh
```

The script generates the chaincode and runtime logs when it runs. It does not use
Hyperledger Composer.

The complete practical repository is available at:

https://github.com/obstinix/lp3

## What the Script Does

When run without an argument, `setup-fabric.sh`:

1. Checks the operating system, RAM, and free disk space.
2. Runs `sudo apt-get update`.
3. Installs Git, curl, jq, Docker, and Docker Compose.
4. Enables and starts Docker.
5. Downloads the pinned Hyperledger Fabric 2.5 LTS samples, binaries, and images.
6. Creates native JavaScript student-registry chaincode.
7. Starts the Fabric test network and creates a channel.
8. Deploys the `studentregistry` chaincode.
9. Adds two sample students.
10. Reads and updates a student record.
11. Prints the resulting transaction output.
12. Saves a timestamped run log and command log.

## Download and Run

Download the script from its GitHub repository after it has been published:

```bash
curl -fLO "https://raw.githubusercontent.com/obstinix/lp3/main/BT/Practical%205/setup-fabric.sh"
```

Inspect it before running:

```bash
less setup-fabric.sh
```

Make it executable:

```bash
chmod +x setup-fabric.sh
```

Run the complete setup:

```bash
./setup-fabric.sh
```

The script may ask for the Linux user's `sudo` password. It never stores the
password. On a first-time Docker installation, it may add the user to the `docker`
group and stop. Log out and back in, then run the same command again so the new
group membership is loaded.

## Script Commands

Run the complete setup and demonstration:

```bash
./setup-fabric.sh
```

Show running Fabric containers:

```bash
./setup-fabric.sh status
```

Stop the Fabric test network:

```bash
./setup-fabric.sh down
```

Stop the network and remove this practical's generated chaincode and logs while
preserving downloaded Fabric samples:

```bash
./setup-fabric.sh clean
```

Show command help:

```bash
./setup-fabric.sh help
```

## Student Registry Chaincode

The script creates a native Fabric JavaScript chaincode package with these
transactions:

| Function | Purpose |
|---|---|
| `AddStudent` | Stores a student by roll number |
| `ReadStudent` | Reads one student |
| `UpdateStudent` | Updates an existing student |
| `GetAllStudents` | Returns all student records |

The sample demonstration executes:

```text
AddStudent(101, Alice, Blockchain Technology)
AddStudent(102, Bob, Computer Engineering)
ReadStudent(101)
UpdateStudent(101, Alice Sharma, Blockchain Technology)
ReadStudent(101)
GetAllStudents()
```

## Understanding the Output

Fabric transaction output includes:

- Proposal response
- Endorsement result
- Commit result
- Transaction identifier
- Chaincode response payload

Unlike the Ethereum practicals, this workflow does not use Ether, MetaMask, or
Ethereum gas fees. Fabric uses peers, an ordering service, channels, endorsement
policies, and transaction validation.

## Logs and Command History

Each run creates files under:

```text
~/fabric-practical-5/logs/
```

The files include:

- A complete timestamped run log
- A command log containing commands executed by the script

The script also appends a few useful commands to the user's Bash history. Reload
the history in the current terminal with:

```bash
history -r
```

Then use the Up Arrow to browse the added commands. Commands executed inside a
child script cannot automatically become live entries in the parent shell's
in-memory history, so the complete command log is the authoritative record.

## Verification

After setup, verify the containers:

```bash
./setup-fabric.sh status
```

Verify the generated logs:

```bash
ls -lh "$HOME/fabric-practical-5/logs"
```

Verify that the network can be stopped:

```bash
./setup-fabric.sh down
```

Run the setup again to verify repeatability:

```bash
./setup-fabric.sh
```

Each setup run resets the Fabric test network before deploying the chaincode, so the
sample records are not duplicated. Do not use the setup command when you need to
preserve the current test ledger; use `status` or `down` instead.

## Result

A modern Hyperledger Fabric test network was started on Ubuntu/Linux Mint. Native
JavaScript chaincode was deployed, student records were created and updated, and
the transaction output was recorded without using deprecated Hyperledger Composer.

## What the Original Practical Asked For

The supplied assignment was titled **Create a Business Network using Hyperledger**.
It described a pharmaceutical supply-chain example called FarmaTrace and referred to:

- Hyperledger Composer Playground
- Composer CLI
- A `.cto` model file
- `logic.js` transaction logic
- `permissions.acl` access rules
- `queries.qry` query definitions
- Hyperledger Fabric peers and an ordering service

The original material was an older Composer tutorial rather than a complete
ready-to-run project. It explained manufacturers, distributors, pharmacies,
hospitals, physicians, customers, and drug receipts, but it did not provide a
current, reproducible setup for a modern operating system.

## Why We Changed the Implementation

Hyperledger Composer was archived and deprecated in 2019. Running its old CLI and
Playground would require obsolete dependencies and old Fabric components. It is not
appropriate for a new practical on a current Ubuntu or Linux Mint installation.

We therefore kept the original learning objective—creating and testing a business
network—but replaced the obsolete toolchain with:

- Hyperledger Fabric 2.5 LTS
- Docker containers
- The Fabric test network
- Native JavaScript chaincode
- Fabric peers, channel, ordering service, and endorsement flow

The pharmaceutical example was reduced to a student registry because it is smaller,
easier to demonstrate in a laboratory session, and still shows business records,
transactions, world state, and ledger history.

## Exact Implementation We Created

The single `setup-fabric.sh` script performs the following sequence:

1. Detects Ubuntu or Linux Mint using `/etc/os-release`.
2. Checks for at least 4 GB RAM and approximately 20 GB free disk space.
3. Requests sudo authentication without storing the password.
4. Runs `sudo apt-get update`.
5. Installs `ca-certificates`, `curl`, `git`, `jq`, Docker, and the available
   Docker Compose v2 package. If the Ubuntu/Mint repositories do not provide
   Compose v2, it configures Docker's official Ubuntu repository instead of using
   deprecated Compose v1.
6. Enables and starts the Docker service.
7. Checks that the current user can access Docker.
8. Downloads the official Fabric installer script.
9. Downloads Fabric 2.5 LTS samples, binaries, and Docker images.
10. Creates the JavaScript chaincode package.
11. Stops any previous test network to guarantee a clean rerun.
12. Starts the Fabric test network and creates `mychannel`.
13. Deploys the `studentregistry` chaincode.
14. Invokes transactions to add two students.
15. Queries student 101.
16. Updates student 101.
17. Queries the updated record and all records.
18. Saves the complete output and command history.

The default pinned versions are:

```text
Fabric: 2.5.16
Fabric CA: 1.5.17
```

They can be overridden before execution if a later tested version is selected:

```bash
FABRIC_VERSION=2.5.16 CA_VERSION=1.5.17 ./setup-fabric.sh
```

## What the Generated Chaincode Does

The script creates a package under:

```text
~/fabric-practical-5/chaincode/studentregistry/
```

The package contains:

- `package.json` for Fabric JavaScript dependencies
- `index.js` for the student-registry contract

The chaincode stores each student under a key such as:

```text
student_101
```

The stored JSON value is similar to:

```json
{
  "docType": "student",
  "rollNo": "101",
  "name": "Alice",
  "course": "Blockchain Technology"
}
```

The functions are:

```text
AddStudent(rollNo, name, course)
ReadStudent(rollNo)
UpdateStudent(rollNo, name, course)
GetAllStudents()
```

`AddStudent` rejects duplicate roll numbers. `ReadStudent` and `UpdateStudent`
reject missing records. `GetAllStudents` scans the student key range and returns
all stored records.

## What Happens Internally

When the script invokes `AddStudent`:

1. The Fabric CLI creates a transaction proposal.
2. The proposal is sent to the Org1 peer.
3. The peer executes the chaincode in simulation.
4. The chaincode reads the current state and prepares a write for `student_101`.
5. The peer returns a signed proposal response.
6. The CLI sends the endorsed transaction to the ordering service.
7. The ordering service places the transaction into a block.
8. The peer validates the endorsement and read/write set.
9. The valid transaction is committed to the ledger.
10. The world state now contains the student record.

A query is different: it reads the peer's current world state and does not create a
new ledger transaction.

## Why Docker Is Used

Fabric consists of several cooperating services. Docker runs those services in
separate, repeatable containers, including:

- Peer containers
- The ordering service
- Certificate authority containers
- Chaincode containers

This avoids manually installing every Fabric service directly on the host and makes
the laboratory setup easier to reset.

## What Is Recorded

The script creates a directory such as:

```text
~/fabric-practical-5/logs/
```

It records:

- The complete terminal output
- The commands executed by the script
- Fabric startup messages
- Chaincode deployment output
- Transaction IDs
- Proposal and query responses
- Errors and warnings

The script also appends useful commands to `~/.bash_history`. Run:

```bash
history -r
```

to reload them in the current terminal. The timestamped command log remains the
complete record because commands inside a child script are not automatically added
to the parent's live Bash history.

## What This Practical Does Not Use

This modern implementation does not use:

- MetaMask
- Ether or Ethereum gas
- Ethereum Sepolia
- Hyperledger Composer
- Composer Playground
- `.cto` files
- Composer ACL files
- Composer REST server

Fabric uses permissioned identities, peers, channels, endorsement, ordering, and
ledger validation instead.
