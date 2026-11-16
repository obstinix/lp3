# Practical 4: Student Data Using Structures, Arrays, and Fallback

## Aim

Write and deploy a Solidity smart contract on the Sepolia test network that stores
student data using structures and arrays, and demonstrates the use of a payable
fallback function. Observe the gas used and transaction fee.

## Objectives

After completing this practical, the student will be able to:

1. Explain the purpose of Solidity and Ethereum smart contracts.
2. Define and use a `struct` to group student fields.
3. Store multiple structures in a dynamic array.
4. Add, read, and update student records.
5. Explain and trigger a payable fallback function.
6. Observe gas used, gas price, and transaction fees.

## Theory

### Blockchain and Ethereum

A blockchain is a distributed ledger maintained by a network of nodes. Ethereum is a
programmable blockchain whose EVM executes smart-contract bytecode. Once a contract
transaction is confirmed, its state is replicated across the network.

### Solidity and Remix

Solidity is a statically typed programming language for Ethereum-compatible smart
contracts. Remix is a browser-based IDE used to write, compile, deploy, and interact
with Solidity contracts.

The Solidity compiler produces:

- **Bytecode:** the compiled instructions deployed to the EVM.
- **ABI:** the interface describing how applications call the contract.

### State and local variables

State variables are declared at contract level and persist on the blockchain. Writing
state costs gas. Local variables exist only during a function call and are not
persisted after the call completes.

### Structures and arrays

A `struct` is a user-defined type that groups related fields of different types. An
array stores multiple values of the same declared type. In this practical, a dynamic
array stores multiple `Student` structures.

### Fallback function

A fallback function is a special function executed when a call does not match a
declared function name. It can also receive Ether when marked `payable`. It has no
name, parameters, or return values. This practical uses it to record an incoming
Ether transfer and emit an event.

## Requirements

- A modern web browser
- MetaMask with the BT practical test account
- Sepolia test network
- Sepolia test ETH
- Remix IDE: https://remix.ethereum.org/

## Important Safety Rules

- Use only Sepolia test ETH; never use real Ether.
- Never share the Secret Recovery Phrase or private key.
- Verify that Remix and MetaMask are connected to Sepolia, not Localhost or Mainnet.
- Review the recipient, amount, and gas fee before approving a transaction.
- Deployed contracts and their data are public on the blockchain.

## Smart Contract Code

Create `StudentRegistry.sol` in Remix and enter:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentRegistry {
    struct Student {
        uint256 rollNo;
        string name;
        string course;
    }

    Student[] private students;
    uint256 public fallbackCallCount;

    event StudentAdded(uint256 indexed index, uint256 rollNo, string name);
    event StudentUpdated(uint256 indexed index, uint256 rollNo, string name);
    event FallbackCalled(address indexed sender, uint256 value, bytes data);

    function addStudent(
        uint256 rollNo,
        string calldata name,
        string calldata course
    ) external {
        require(bytes(name).length > 0, "Name is required");
        students.push(Student(rollNo, name, course));
        emit StudentAdded(students.length - 1, rollNo, name);
    }

    function getStudent(uint256 index)
        external
        view
        returns (uint256 rollNo, string memory name, string memory course)
    {
        require(index < students.length, "Student does not exist");
        Student storage student = students[index];
        return (student.rollNo, student.name, student.course);
    }

    function getStudentCount() external view returns (uint256) {
        return students.length;
    }

    function updateStudent(
        uint256 index,
        uint256 rollNo,
        string calldata name,
        string calldata course
    ) external {
        require(index < students.length, "Student does not exist");
        require(bytes(name).length > 0, "Name is required");
        students[index] = Student(rollNo, name, course);
        emit StudentUpdated(index, rollNo, name);
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    fallback() external payable {
        fallbackCallCount++;
        emit FallbackCalled(msg.sender, msg.value, msg.data);
    }
}
```

    Remix may display a warning saying that the contract has a payable fallback but no
    `receive()` function. This is intentional for this practical: the fallback function
    is being demonstrated as the Ether-receiving function. It is a warning, not a
    compilation error, and the contract can still be deployed. Do not add `receive()`
    unless you also change the fallback experiment, because a plain Ether transfer would
    then call `receive()` instead of `fallback()`.

## Procedure

### A. Create and compile the contract

1. Open [Remix IDE](https://remix.ethereum.org/).
2. In **File Explorers**, click **Create new file** and name it
   `StudentRegistry.sol`.
3. Enter the contract code above and save it with **Ctrl+S**.
4. Open **Solidity Compiler** from the left toolbar.
5. Select compiler version `0.8.20` or another compatible `0.8.x` version.
6. Click **Compile StudentRegistry.sol** and confirm that compilation succeeds.

### B. Deploy the contract

7. Open **Deploy & Run Transactions**.
8. Set **Environment** to **Injected Provider - MetaMask**.
9. Approve the connection request in MetaMask.
10. Confirm that MetaMask and Remix show the Sepolia network and the correct account.
    If Localhost appears, cancel and switch MetaMask to Sepolia.
11. Confirm that **Contract** is set to `StudentRegistry`.
12. Click **Deploy**, review the gas estimate, and click **Confirm** in MetaMask.
13. Wait for confirmation and expand the deployed `StudentRegistry` contract.
14. Record the deployed contract address and deployment transaction hash.

### C. Add student records

15. In the deployed contract, locate `addStudent`.
16. Enter these sample values:

    ```text
    rollNo: 101
    name: Alice
    course: Blockchain Technology
    ```

17. Click **transact** or **addStudent**. Review the gas fee in MetaMask and confirm.
18. Wait for confirmation and record the transaction hash.
19. Add a second record, for example:

    ```text
    rollNo: 102
    name: Bob
    course: Computer Engineering
    ```

20. Confirm the second transaction and record its hash.

### D. Read student data

21. Click **getStudentCount**. The result should be `2`.
22. Call **getStudent** with index `0`. Confirm that it returns Alice's roll number,
    name, and course.
23. Call **getStudent** with index `1`. Confirm that it returns Bob's details.
24. Read functions do not change state and normally do not require a gas fee in Remix.

### E. Update a student record

25. Locate `updateStudent` and enter:

    ```text
    index: 0
    rollNo: 101
    name: Alice Sharma
    course: Blockchain Technology
    ```

26. Click **transact**, review the transaction in MetaMask, and confirm it.
27. After confirmation, call **getStudent(0)** and verify the updated record.
28. Record the update transaction hash and gas details.

### F. Trigger the fallback function

29. Copy the deployed `StudentRegistry` contract address from Remix.
30. Open MetaMask, click **Send**, and paste the deployed contract address as the
    recipient. Compare the pasted address with the address recorded after deployment.
31. Enter a small amount such as `0.001` Sepolia ETH. If the amount must be entered
    in wei, use `1000000000000000`.
32. Review the destination address, amount, network, and gas fee. Confirm that the
    destination is the deployed contract, then click **Confirm**.
33. Because the contract has no `receive()` function, a plain Ether transfer with no
    function data invokes its payable `fallback()` function.
34. Wait for confirmation and record the fallback transaction hash.
35. Return to Remix and click **fallbackCallCount**. It should have increased by one.
36. Click **getContractBalance** and record the contract's balance in wei.

### G. Observe gas and transaction fees

36. Open the deployment, `addStudent`, `updateStudent`, and fallback transactions in
    a Sepolia block explorer using their transaction hashes.
37. Record **Gas Used**, **Gas Price**, and **Transaction Fee** for each transaction.
38. Compare state-changing transactions with read-only calls. Deployment, adding,
    updating, and fallback transfers require gas; getter calls normally do not.
39. If the fee is not displayed directly, calculate it as:

    `Transaction fee (ETH) = Gas used × Gas price (Gwei) ÷ 1,000,000,000`

## Observation Table

| Item | Value |
|---|---|
| Network | Sepolia |
| Contract address | |
| Deployment transaction hash | |
| Student 1 transaction hash | |
| Student 2 transaction hash | |
| Update transaction hash | |
| Fallback transaction hash | |
| Student count | |
| Fallback call count | |
| Contract balance | |
| Gas used | |
| Gas price | |
| Transaction fee in ETH | |

## Result

A student registry smart contract was compiled and deployed on Sepolia. Student
records were stored using structures in a dynamic array, read and updated through
contract functions, and the payable fallback function was triggered. Gas usage and
transaction fees were observed for the state-changing operations.
