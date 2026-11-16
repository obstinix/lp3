# Assignment 4: Student Data Using Structures, Arrays, and Fallback

## Viva Questions and Answers

### 1. What is the aim of this practical?
The aim is to create a Solidity smart contract that stores student data using
structures and arrays, demonstrates a fallback function, and measures transaction
gas and fees.

### 2. What is Solidity?
Solidity is a statically typed, high-level programming language used to write smart
contracts for the Ethereum Virtual Machine.

### 3. What is Ethereum?
Ethereum is a programmable blockchain. It stores smart-contract state and executes
contract bytecode through its distributed network of EVM nodes.

### 4. What is a smart contract?
A smart contract is a program deployed to a blockchain. Its functions and stored
state are executed according to its code after transactions are confirmed.

### 5. What is a `struct`?
A `struct` is a user-defined data type that groups related values, possibly of
different types, into one record.

### 6. Explain the `Student` structure.

```solidity
struct Student {
    uint256 rollNo;
    string name;
    string course;
}
```

It groups a student's roll number, name, and course. Each `Student` value represents
one complete student record.

### 7. What is the purpose of the `students` array?

```solidity
Student[] private students;
```

It is a dynamic array that stores any number of `Student` structures. New records are
added using `push`, and each record is accessed by a zero-based index.

### 8. What is a dynamic array?
A dynamic array can grow or shrink during contract execution. Its length is not fixed
when the contract is deployed.

### 9. Why does the first student use index `0`?
Solidity arrays are zero-indexed. The first record is at index `0`, the second at
index `1`, and so on.

### 10. Explain the `addStudent` function.
The function receives a roll number, name, and course, checks that the name is not
empty, appends a new `Student` structure to the array, and emits a `StudentAdded`
event. It changes blockchain state, so it requires gas.

### 11. Why is `students.push` used?
`push` appends a new element to the end of a dynamic storage array and increases its
length by one.

### 12. What is the purpose of `getStudent`?
It reads a student record at a given index and returns the roll number, name, and
course. It is marked `view`, so it normally does not require gas when called from
Remix.

### 13. Why does `getStudent` check the index?
The condition `index < students.length` prevents access outside the array. If the
condition fails, the transaction or call reverts with **Student does not exist**.

### 14. What does `getStudentCount` return?
It returns `students.length`, which is the number of records currently stored in the
array.

### 15. What does `updateStudent` do?
It replaces the structure at an existing index with new values. Because it changes
storage, calling it requires a transaction and gas.

### 16. What is a fallback function?
A fallback function is a special unnamed function that runs when a call does not match
any declared function. It can receive Ether when declared `payable`.

### 17. Explain the fallback function in this practical.

```solidity
fallback() external payable {
    fallbackCallCount++;
    emit FallbackCalled(msg.sender, msg.value, msg.data);
}
```

It accepts an incoming Ether transfer or an unmatched call, increments the fallback
counter, and records the sender, amount, and call data in an event.

### 18. What is the difference between `fallback` and `receive`?
`receive()` is selected for a plain Ether transfer with empty call data. `fallback()`
is selected when no function matches or when call data is present. This practical uses
a payable fallback to demonstrate the behavior.

### 19. Why is the fallback function marked `payable`?
Without `payable`, the contract would reject Ether sent to the fallback function.
`payable` allows the function to receive Ether.

### Compiler warning: no `receive()` function

Remix may warn that the contract has a payable fallback but no `receive()` function.
This is not a compilation error. The practical intentionally uses the fallback to
demonstrate Ether reception. If a separate `receive()` function were added, a plain
Ether transfer would call `receive()` instead of `fallback()`, so the experiment
would need to be changed.

### 20. What is `fallbackCallCount`?
It is a state variable that records how many times the fallback function has been
executed. Each increment changes blockchain state and costs gas.

### 21. What are events?
Events are transaction logs emitted by a contract. They allow applications and block
explorers to track actions such as adding a student or triggering the fallback.

### 22. What does `indexed` mean in an event?
An indexed event field can be efficiently filtered by applications and block
explorers. In this practical, the student index and sender address are indexed.

### 23. What is the difference between state and local variables?
State variables are stored permanently on the blockchain. Local variables exist only
while a function executes and are not permanently stored.

### 24. What is the difference between `view` and `pure`?
`view` functions can read contract state but cannot modify it. `pure` functions
cannot read or modify contract state; they operate only on their inputs and local
values.

### 25. What is the ABI?
The Application Binary Interface describes a contract's functions, parameters, return
values, and events. Remix uses the ABI to create the controls for calling a deployed
contract.

### 26. What is bytecode?
Bytecode is the compiled EVM instruction sequence deployed to the blockchain. The EVM
executes it when users call the contract.

### 27. What is a constructor?
A constructor runs once during contract deployment. The contract in this practical
does not require a constructor because its array and counter start with default values.

### 28. Why do `addStudent` and `updateStudent` require gas?
They modify the `students` array stored on the blockchain. Validators execute and
record those changes, so the caller pays gas.

### 29. Why do getter functions normally not require gas?
`getStudent`, `getStudentCount`, and `getContractBalance` are read-only calls. Remix
can execute them without creating a state-changing blockchain transaction.

### 30. How is the transaction fee calculated?
When gas price is shown in Gwei:

```text
Transaction fee (ETH) =
Gas used × Gas price (Gwei) ÷ 1,000,000,000
```

The fee is paid in ETH on Sepolia.

### 31. What is the conclusion of this practical?
A student registry contract was deployed on Sepolia. Structures and arrays stored
student data, records were read and updated, the fallback function received Ether,
and gas usage and transaction fees were observed.

## Complete Program Explanation

### Contract declaration and storage

```solidity
contract StudentRegistry {
    struct Student {
        uint256 rollNo;
        string name;
        string course;
    }

    Student[] private students;
    uint256 public fallbackCallCount;
```

`StudentRegistry` is the contract name. The `Student` structure groups three fields.
The `students` array stores every record, while `fallbackCallCount` stores the number
of fallback executions.

### Events

```solidity
event StudentAdded(uint256 indexed index, uint256 rollNo, string name);
event StudentUpdated(uint256 indexed index, uint256 rollNo, string name);
event FallbackCalled(address indexed sender, uint256 value, bytes data);
```

These declarations define logs that are written into transaction receipts. Events
make it possible for front-end applications and block explorers to observe contract
activity without repeatedly reading every state variable.

### Adding a student

```solidity
function addStudent(
    uint256 rollNo,
    string calldata name,
    string calldata course
) external {
    require(bytes(name).length > 0, "Name is required");
    students.push(Student(rollNo, name, course));
    emit StudentAdded(students.length - 1, rollNo, name);
}
```

The function receives three inputs. `calldata` is an efficient read-only area for
external function arguments. The `require` rejects an empty name. `push` adds the
record to storage, and the event reports the new zero-based index.

### Reading a student

```solidity
function getStudent(uint256 index)
    external
    view
    returns (uint256 rollNo, string memory name, string memory course)
{
    require(index < students.length, "Student does not exist");
    Student storage student = students[index];
    return (student.rollNo, student.name, student.course);
}
```

The function validates the requested index, references the stored record, and
returns its three fields. `view` ensures that it cannot modify the array.

### Updating a student

```solidity
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
```

The function checks that the record exists, validates the name, replaces the
structure at the selected index, and emits an update event.

### Fallback and contract balance

```solidity
fallback() external payable {
    fallbackCallCount++;
    emit FallbackCalled(msg.sender, msg.value, msg.data);
}

function getContractBalance() external view returns (uint256) {
    return address(this).balance;
}
```

When Ether is sent to the contract without a matching function call, the payable
fallback executes. It records the call and receives the Ether. The contract balance
function returns the Ether held by the deployed contract in wei.

## Transaction Flow

1. Compile `StudentRegistry.sol` in Remix.
2. Deploy it through MetaMask on Sepolia.
3. Call `addStudent` to append student records.
4. Call `getStudentCount` and `getStudent` to verify the records.
5. Call `updateStudent` and verify the changed record.
6. Send a small amount of Sepolia ETH to trigger the fallback.
7. Read `fallbackCallCount` and `getContractBalance`.
8. Use transaction hashes in a Sepolia block explorer to record gas and fees.

## Ether, Gwei, and Wei Conversions

Solidity and Ethereum represent Ether amounts internally in **wei**. Remix may allow
the transaction value to be entered in ETH, Gwei, or wei.

```text
1 ETH  = 1,000,000,000 Gwei
1 ETH  = 1,000,000,000,000,000,000 wei
1 Gwei = 1,000,000,000 wei
```

Useful values for this practical are:

```text
0.001 ETH = 1,000,000 Gwei             = 1,000,000,000,000,000 wei
0.01 ETH  = 10,000,000 Gwei            = 10,000,000,000,000,000 wei
```

The `value` field in the `FallbackCalled` event and the result of
`getContractBalance()` are returned in wei. For example:

```text
1,000,000,000,000,000 wei ÷ 1,000,000,000,000,000,000
= 0.001 ETH
```

### Gas price and transaction fee

Gas price is commonly displayed in Gwei, while the final transaction fee is usually
displayed in ETH. The fee can be calculated as:

```text
Transaction fee (ETH) =
Gas used × Gas price (Gwei) ÷ 1,000,000,000
```

For example, if a transaction uses `100,000` gas at `20 Gwei`:

```text
100,000 × 20 ÷ 1,000,000,000 = 0.002 ETH
```

The Ether value sent to the contract is separate from the gas fee paid to process
the transaction.

## Important Program Details

### Why student data is stored in a struct

The `Student` struct keeps related fields together:

```solidity
struct Student {
    uint256 rollNo;
    string name;
    string course;
}
```

Without a struct, separate arrays would be needed for roll numbers, names, and
courses. A struct keeps one student's data as one logical record.

### Why the array is private

```solidity
Student[] private students;
```

The array is private so users cannot use an automatically generated array getter to
read an incomplete record. The contract instead exposes `getStudent`, which validates
the index and returns all three fields together. Private blockchain state is not
secret; the contract storage remains publicly inspectable on the network.

### Why `calldata` is used

The `name` and `course` parameters use `calldata` because they are read-only input
values for external functions. `calldata` avoids copying those values into mutable
memory before the function uses them and is generally efficient for external calls.

### Why `bytes(name).length` is used

Solidity strings do not have a simple numeric length property. Converting the string
to `bytes` allows the contract to check whether the name contains at least one byte:

```solidity
require(bytes(name).length > 0, "Name is required");
```

An empty name causes the transaction to revert.

### How fallback dispatch works

When a transaction reaches the contract, the EVM compares its call data with the
declared function selectors:

1. If the data matches `addStudent`, `getStudent`, or another declared function,
   that function runs.
2. If the data is empty and no `receive()` function exists, the payable fallback runs.
3. If the data does not match any declared function, the fallback also runs.
4. If the fallback were not payable and Ether were attached, the transfer would fail.

In this practical, sending plain Sepolia ETH to the deployed contract address invokes
the fallback because the contract intentionally has no `receive()` function.

### Complete execution example

Assume the following operations:

1. The contract is deployed. The student array is empty and
   `fallbackCallCount` is `0`.
2. `addStudent(101, "Alice", "Blockchain Technology")` appends record index `0`.
3. `addStudent(102, "Bob", "Computer Engineering")` appends record index `1`.
4. `getStudentCount()` returns `2`.
5. `updateStudent(0, 101, "Alice Sharma", "Blockchain Technology")` replaces the
   record at index `0`.
6. Sending `0.001 ETH` to the contract invokes `fallback()`, increases
   `fallbackCallCount` to `1`, and increases the contract balance by
   `1,000,000,000,000,000 wei`.
7. `getContractBalance()` returns the contract's complete balance in wei.

The add and update operations modify student storage. The fallback transfer modifies
the counter and contract balance. Each of these state changes is a blockchain
transaction and requires gas. The getter calls only read data and normally do not
create a paid transaction in Remix.

### Meaning of successful and reverted calls

- A successful `addStudent` transaction stores a new record.
- A successful `updateStudent` transaction changes an existing record.
- A successful fallback transaction records the call and accepts the Ether.
- An invalid student index causes `getStudent` or `updateStudent` to revert.
- An empty student name causes `addStudent` or `updateStudent` to revert.
- A non-payable fallback would reject an Ether transfer, but this practical uses a
  payable fallback.
