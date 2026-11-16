# Assignment 5: Modern Hyperledger Fabric Student Registry

## Viva Questions and Answers

### 1. What is the aim of this practical?
The aim is to set up a Hyperledger Fabric test network and deploy native JavaScript
chaincode for creating, reading, updating, and listing student records.

### 2. Does this practical use Hyperledger Composer?
No. Hyperledger Composer was deprecated and archived in 2019. This practical uses
the Fabric test network, Fabric peer tools, Docker, and native chaincode.

### 3. What is Hyperledger Fabric?
Hyperledger Fabric is a permissioned, modular blockchain platform designed for
business networks. Participants are identified by digital certificates rather than
anonymous public blockchain accounts.

### 4. What is a permissioned blockchain?
A permissioned blockchain requires participants to be known and authorized. An
organization's membership service provider controls identities and access.

### 5. What is a peer?
A peer hosts ledgers and chaincode. It endorses transaction proposals and commits
validated transactions to its local copy of the ledger.

### 6. What is an ordering service?
The ordering service receives endorsed transactions, establishes their order, and
creates blocks for the peers to validate and commit.

### 7. What is a channel?
A channel is a private logical communication and ledger partition for selected
organizations. Transactions on one channel are not automatically visible on another.

### 8. What is chaincode?
Chaincode is Fabric's term for smart-contract business logic. It reads and changes
world-state data through the Fabric contract API.

### 9. What language is used for the chaincode?
This practical uses JavaScript with `fabric-contract-api` and `fabric-shim`.
Fabric also supports chaincode written in languages such as Go and Java.

### 10. What is world state?
World state is the current database view of all ledger records. The blockchain
history contains the sequence of transactions that produced those records.

### 11. What is the ledger?
The ledger consists of the blockchain transaction history and the current world
state. The history is append-only, while the world state provides efficient reads.

### 12. What is an endorsement?
An endorsement is a signed response from a peer stating that it simulated a
transaction proposal and produced the expected result.

### 13. What is an endorsement policy?
It defines which organizations or peers must endorse a transaction before it can be
committed. The policy helps ensure that required organizations approve the change.

### 14. What does Docker do in this practical?
Docker runs the Fabric components as isolated containers, including peers, the
ordering service, certificate authorities, and chaincode containers.

### 15. Why is Bash used?
Bash automates installation, configuration, network startup, chaincode deployment,
transactions, logging, and cleanup in one repeatable workflow.

### 16. Why does the script use `sudo apt-get update`?
It refreshes the Linux package index before installing required packages. The script
then installs Docker, Git, curl, jq, and related utilities.

### 17. Is the script compatible with every computer?
No. It targets Ubuntu/Linux Mint systems with Bash, internet access, sudo
permissions, Docker support, adequate RAM, and adequate disk space.

### 18. What is the purpose of `AddStudent`?
It creates a student record and stores it in the ledger using a key based on the
student's roll number.

### 19. What is the purpose of `ReadStudent`?
It retrieves one student record from the ledger using the roll number.

### 20. What is the purpose of `UpdateStudent`?
It replaces the name and course of an existing student record.

### 21. What is the purpose of `GetAllStudents`?
It iterates over the ledger key range used by the student records and returns all
stored student objects.

### 22. What is a transaction ID?
A transaction ID uniquely identifies a Fabric transaction. It can be used to connect
proposal, endorsement, ordering, and commit output.

### 23. Does Fabric use Ethereum gas or Ether?
No. This Fabric practical does not use MetaMask, Ether, Ethereum gas, or an Ethereum
testnet. Fabric nodes use their own permissioned network and transaction process.

### 24. What is the difference between Fabric and Ethereum?
Ethereum is generally a public programmable blockchain using accounts and gas.
Fabric is a permissioned modular network with known organizations, channels, peers,
ordering, and endorsement policies.

### 25. What is the difference between Composer and Fabric chaincode?
Composer provided a higher-level business-network abstraction with `.cto`, ACL, and
Composer CLI files. This practical uses Fabric's native chaincode APIs directly.

### 26. What happens when `AddStudent` is invoked?
The client sends a proposal to a peer. The peer executes the chaincode simulation,
returns a proposal response, and the endorsed transaction is sent to the ordering
service. After validation, peers commit the resulting state.

### 27. What happens if a student already exists?
The chaincode checks the ledger key and throws an error. The duplicate transaction
does not update the existing record.

### 28. What happens if a student does not exist?
`ReadStudent` and `UpdateStudent` throw an error when the requested ledger key has no
data.

### 29. What is the purpose of the command log?
It provides a persistent record of the commands used during setup and testing. It is
the authoritative history because child-script commands are not automatically added
to the parent shell's live history.

### 30. How can the command history be viewed?
Read the timestamped files under:

```text
~/fabric-practical-5/logs/
```

Run `history -r` and use the Up Arrow to browse the key commands appended by the
script.

### 31. What is the conclusion of this practical?
A modern Hyperledger Fabric test network was created with Docker, native JavaScript
chaincode was deployed, student records were manipulated, and the transaction
results were recorded without using deprecated Composer.

## Program Explanation

### 1. Chaincode package

The script creates a `package.json` file containing the Fabric contract dependencies:

```json
{
  "name": "student-registry",
  "main": "index.js",
  "dependencies": {
    "fabric-contract-api": "2.5.16",
    "fabric-shim": "2.5.16"
  }
}
```

The package tells the Fabric chaincode builder which JavaScript libraries must be
installed before the chaincode container runs.

### 2. Contract class

```javascript
const { Contract } = require('fabric-contract-api');

class StudentRegistryContract extends Contract {
```

The `Contract` base class supplies the Fabric contract interface. The
`StudentRegistryContract` class defines the business operations for the practical.

### 3. Adding a record

```javascript
async AddStudent(ctx, rollNo, name, course) {
    const key = `student_${rollNo}`;
    const existing = await ctx.stub.getState(key);
    if (existing && existing.length > 0) {
        throw new Error(`Student ${rollNo} already exists`);
    }

    const student = { docType: 'student', rollNo, name, course };
    await ctx.stub.putState(key, Buffer.from(JSON.stringify(student)));
    return JSON.stringify(student);
}
```

`ctx` is the Fabric transaction context. `getState` reads the current world state.
The key is based on the roll number. `putState` writes the JSON-encoded student
object to the ledger. The function rejects duplicate roll numbers.

### 4. Reading a record

```javascript
async ReadStudent(ctx, rollNo) {
    const key = `student_${rollNo}`;
    const data = await ctx.stub.getState(key);
    if (!data || data.length === 0) {
        throw new Error(`Student ${rollNo} does not exist`);
    }
    return data.toString();
}
```

The function reads the ledger value, checks that it exists, converts the stored
Buffer to text, and returns the student JSON.

### 5. Updating a record

```javascript
async UpdateStudent(ctx, rollNo, name, course) {
    const key = `student_${rollNo}`;
    const data = await ctx.stub.getState(key);
    if (!data || data.length === 0) {
        throw new Error(`Student ${rollNo} does not exist`);
    }

    const student = { docType: 'student', rollNo, name, course };
    await ctx.stub.putState(key, Buffer.from(JSON.stringify(student)));
    return JSON.stringify(student);
}
```

The function first verifies that the key exists, creates the updated object, and
writes it back to the same ledger key.

### 6. Listing all students

```javascript
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
```

The range query selects keys beginning with `student_`. The iterator is consumed,
each JSON record is parsed, and the iterator is closed before the result is returned.

### 7. Transaction lifecycle

1. The Fabric CLI creates a proposal.
2. The peer executes the chaincode simulation.
3. The peer returns a signed endorsement.
4. The client sends the endorsed transaction to the ordering service.
5. The ordering service places it in a block.
6. Peers validate the endorsement and read/write sets.
7. Valid transactions update world state and become part of the ledger history.

## Result

The modern Fabric student registry was deployed and tested using one repeatable
Bash script. Student records were added, read, updated, and listed on a permissioned
Fabric test network without using deprecated Hyperledger Composer.

## Detailed Explanation of the Practical

### 1. What was supplied originally

The original assignment asked for a Hyperledger business network and described a
pharmaceutical supply chain. It referred to Hyperledger Composer components such as
`.cto`, `logic.js`, `permissions.acl`, `queries.qry`, Composer Playground, and the
Composer CLI.

Those instructions represented an older Fabric development model. They were useful
for understanding business networks, assets, participants, transactions, and access
rules, but Composer is now archived and deprecated.

### 2. What was implemented instead

The practical was modernized as a Fabric-native student registry. This preserves the
business-network learning objective while removing obsolete Composer dependencies.
The implementation uses:

- A Bash setup script
- Ubuntu or Linux Mint
- Docker
- Hyperledger Fabric 2.5 LTS
- A Fabric test network
- A Fabric channel called `mychannel`
- Native JavaScript chaincode
- Org1's peer and identity

The student registry was selected because it demonstrates the same important
business-network ideas with fewer entities and less setup than a pharmaceutical
supply chain.

### 3. Why the setup script is useful

Installing Fabric manually requires many commands and several coordinated services.
The script puts those commands into one repeatable workflow. It also checks resources,
installs prerequisites, downloads Fabric, creates the chaincode, starts Docker
containers, deploys the chaincode, runs transactions, and saves logs.

The setup is repeatable because each normal setup run first tears down the old test
network. This prevents previous student records from causing duplicate-key errors.

### 4. What happens during setup

The script begins with:

```bash
#!/usr/bin/env bash
set -Eeuo pipefail
```

The shebang tells Linux to execute the file with Bash. Strict mode makes unset
variables, failed commands, and pipeline failures visible instead of silently
continuing.

It then:

1. Reads configuration such as Fabric version and working directory.
2. Creates a timestamped log directory.
3. Sends terminal output to both the screen and a log file.
4. Checks the operating system and available resources.
5. Installs Docker and command-line dependencies using `sudo apt-get`.
6. Downloads Fabric samples, binaries, and images.
7. Writes the chaincode files.
8. Starts the network and deploys the chaincode.

### 5. Why the script checks Docker access

Fabric's peers, orderer, certificate authorities, and chaincode run in Docker
containers. Installing Docker is not enough; the current Linux user must also be
allowed to communicate with the Docker daemon. If access is missing, the script adds
the user to the Docker group and asks the user to log out and back in.

### 6. What the chaincode package contains

The generated package contains `package.json` and `index.js`. `package.json` lists
the Fabric contract dependencies. `index.js` exports the
`StudentRegistryContract` class to Fabric:

```javascript
module.exports.contracts = [StudentRegistryContract];
```

This export tells the Fabric chaincode runtime which contract class is available for
invocation.

### 7. How a student is stored

When the script invokes:

```text
AddStudent(101, Alice, Blockchain Technology)
```

the chaincode creates:

```text
key:   student_101
value: {"docType":"student","rollNo":"101","name":"Alice","course":"Blockchain Technology"}
```

The key makes the record easy to retrieve. The value is JSON encoded into a Buffer
because Fabric ledger APIs store bytes.

### 8. Why duplicate records are rejected

Before writing a student, the chaincode calls:

```javascript
const existing = await ctx.stub.getState(key);
```

If data already exists, the chaincode throws an error. This prevents silently
overwriting an existing student during `AddStudent`.

### 9. What `ctx` means

`ctx` is the Fabric transaction context. It provides access to:

- `ctx.stub.getState` for reading ledger values
- `ctx.stub.putState` for writing ledger values
- `ctx.stub.getStateByRange` for range queries
- Transaction metadata and the calling identity

### 10. What `GetAllStudents` does

The function calls:

```javascript
ctx.stub.getStateByRange('student_', 'student_\uffff')
```

The key range selects records whose keys begin with `student_`. The function
iterates over the returned result, parses each JSON value, closes the iterator, and
returns a JSON array.

### 11. Exact demonstration transactions

The script runs:

```text
AddStudent(101, Alice, Blockchain Technology)
AddStudent(102, Bob, Computer Engineering)
ReadStudent(101)
UpdateStudent(101, Alice Sharma, Blockchain Technology)
ReadStudent(101)
GetAllStudents()
```

The expected final records are equivalent to:

```json
[
  {
    "docType": "student",
    "rollNo": "101",
    "name": "Alice Sharma",
    "course": "Blockchain Technology"
  },
  {
    "docType": "student",
    "rollNo": "102",
    "name": "Bob",
    "course": "Computer Engineering"
  }
]
```

### 12. Transaction versus query

`AddStudent` and `UpdateStudent` change ledger state. They require endorsement,
ordering, validation, and commit.

`ReadStudent` and `GetAllStudents` read the current world state. They do not create
a new block or change the ledger.

### 13. What the Fabric network components do

- **Certificate Authority:** issues identities and certificates.
- **Peer:** endorses proposals and stores ledger data.
- **Orderer:** orders endorsed transactions into blocks.
- **Channel:** provides a shared ledger namespace.
- **Chaincode:** implements the student business rules.
- **CLI:** submits proposals and queries.
- **Docker:** runs the components consistently.

### 14. Why this is not an Ethereum practical

This practical does not use MetaMask, Ether, Solidity, Ethereum gas, or Sepolia.
Fabric is permissioned and uses organizational identities, endorsement policies,
channels, peers, and an ordering service.

### 15. Why the old Composer files are absent

Composer supplied a high-level abstraction over Fabric. Since Composer is archived,
the modern practical uses Fabric's native contract API directly. Therefore the
student should not expect `.cto`, `permissions.acl`, or Composer Playground screens
in this implementation.

### 16. How the command history works

The script uses Bash tracing and a command recorder. It writes timestamped files
under:

```text
~/fabric-practical-5/logs/
```

The complete log is more reliable than the Up Arrow because a child script cannot
automatically modify the parent shell's in-memory history. The script appends useful
commands to `~/.bash_history`; running `history -r` reloads them so the Up Arrow can
browse them.

### 17. Why the setup can be rerun

The setup command stops the existing test network before creating a clean one. This
prevents stale containers, old chaincode definitions, and duplicate student records
from affecting the demonstration.

### 18. What happens when a transaction is committed

1. The CLI creates a proposal.
2. The peer simulates the chaincode.
3. The peer returns an endorsement.
4. The client sends the endorsed proposal to the orderer.
5. The orderer places it in a block.
6. Peers validate the read/write set and endorsements.
7. Valid transactions update the world state.
8. The transaction ID and block information are recorded in the log.

This is the modern Fabric equivalent of demonstrating a business-network
transaction, without relying on the deprecated Composer toolchain.
