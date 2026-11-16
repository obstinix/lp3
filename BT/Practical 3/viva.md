# Assignment 3: Bank Account Smart Contract

## Viva Questions and Answers

### 1. What is the aim of this practical?
The aim is to write and deploy a bank smart contract that supports deposits,
withdrawals, and balance checking on an Ethereum test network.

### 2. What is a smart contract?
A smart contract is a program deployed on a blockchain. Its code and stored state
are executed by the network according to predefined rules.

### 3. What is the purpose of the `Bank` contract?
It stores Ether received from users and records the amount belonging to each user.
Each account can withdraw only its own recorded balance.

### 4. What is a mapping in Solidity?
A mapping is a key-value data structure. In this practical, an Ethereum address is
the key and its Ether balance in wei is the value.

### 5. Explain this declaration:

```solidity
mapping(address => uint256) private balances;
```

It creates a mapping named `balances`. Each address maps to a non-negative integer.
The `private` keyword prevents direct external access to the variable; the contract's
functions provide controlled access.

### 6. What is `msg.sender`?
`msg.sender` is the address that called the current function. It is used to associate
a deposit or withdrawal with the correct account.

### 7. What is `msg.value`?
`msg.value` is the amount of Ether, measured in wei, attached to the current payable
transaction.

### 8. Why is the `deposit` function payable?
A function must be marked `payable` to receive Ether. Without `payable`, a transaction
that sends Ether to the function will fail.

### 9. Explain the deposit operation.
The caller attaches Ether to `deposit`. The contract checks that the amount is
greater than zero and adds `msg.value` to `balances[msg.sender]`.

### 10. Why is the deposit amount entered in the Value field?
The Value field attaches Ether to the transaction. The `deposit()` function receives
that Ether through `msg.value`.

### 11. What is wei?
Wei is the smallest unit of Ether.

```text
1 ETH = 1,000,000,000,000,000,000 wei
```

Therefore, `0.01 ETH` equals `10,000,000,000,000,000 wei`.

### 12. Explain the `getBalance` function.
`getBalance` returns the balance recorded for `msg.sender` in the `balances` mapping.
It is marked `view`, so it does not modify blockchain state.

### 13. What is the difference between `getBalance` and `getContractBalance`?
`getBalance` returns the caller's internal accounting balance. `getContractBalance`
returns all Ether physically held by the contract address.

### 14. Explain the withdrawal checks.
The contract first checks that the requested amount is greater than zero and does not
exceed the caller's recorded balance. If either check fails, the transaction reverts.

### 15. Why is the balance reduced before sending Ether?
Updating the internal balance before making the external transfer follows the
checks-effects-interactions pattern and helps prevent reentrancy attacks.

### 16. What is reentrancy?
Reentrancy occurs when an external contract called during a withdrawal calls back into
the original contract before the first call has finished. Without protection, it may
withdraw repeatedly using an unchanged balance.

### 17. How does this contract protect against reentrancy?
It reduces the caller's balance before the transfer and uses the `nonReentrant`
modifier. The modifier prevents a second entry into `withdraw` while a withdrawal is
already executing.

### 18. What does the `nonReentrant` modifier do?
It checks that `locked` is false, sets it to true while the function runs, and resets
it to false after completion. A nested call fails while the lock is true.

### 19. Why does the contract use `call` for the Ether transfer?
`call{value: amount}("")` sends Ether and returns a success flag. The contract checks
that flag and reverts if the transfer fails.

### 20. What is an event?
An event writes a log entry to the transaction receipt. `Deposit` and `Withdrawal`
events make it easier for applications and block explorers to track activity.

### 21. What happens when a withdrawal exceeds the balance?
The `require` check fails and the transaction reverts with **Insufficient balance**.
The state change and Ether transfer do not occur.

### 22. Why are deposit and withdrawal transactions charged gas?
Both operations change contract storage and may transfer Ether. Validators must
execute and record these changes, so the caller pays a gas fee.

### 23. Why does calling `getBalance` normally not cost gas?
`getBalance` is a read-only `view` function. When called locally through Remix, it
does not create a blockchain transaction.

### 24. What is the difference between the contract balance and user balances?
The contract balance is the total Ether held at the contract address. User balances
are internal records showing how much of that total is assigned to each account.

### 25. What is the conclusion of this practical?
A bank smart contract was deployed on Sepolia and used to deposit Ether, withdraw
Ether, display an account balance, reject an excessive withdrawal, and study gas fees.

## Code Explanation

### Contract and state

```solidity
contract Bank {
    mapping(address => uint256) private balances;
    bool private locked;
```

`Bank` is the contract name. `balances` stores each user's amount in wei, while
`locked` is used by the reentrancy guard.

### Deposit

```solidity
function deposit() external payable {
    require(msg.value > 0, "Deposit must be greater than zero");
    balances[msg.sender] += msg.value;
    emit Deposit(msg.sender, msg.value);
}
```

The function accepts Ether, rejects a zero deposit, adds the amount to the caller's
recorded balance, and emits a deposit log.

### Withdrawal

```solidity
function withdraw(uint256 amount) external nonReentrant {
    require(amount > 0, "Withdrawal must be greater than zero");
    require(amount <= balances[msg.sender], "Insufficient balance");
    balances[msg.sender] -= amount;
    (bool success, ) = payable(msg.sender).call{value: amount}("");
    require(success, "Transfer failed");
    emit Withdrawal(msg.sender, amount);
}
```

The function validates the amount, verifies sufficient funds, decreases the internal
balance, sends Ether to the caller, checks the transfer result, and records an event.
The balance update occurs before the external call for security.

### Balance functions

```solidity
function getBalance() external view returns (uint256) {
    return balances[msg.sender];
}

function getContractBalance() external view returns (uint256) {
    return address(this).balance;
}
```

`getBalance` returns the caller's internal balance. `getContractBalance` returns the
total Ether held by the contract. Both functions are read-only.

## Transaction Flow

1. The user opens the deployed contract in Remix.
2. The user enters an Ether amount in the Value field and calls `deposit`.
3. MetaMask asks the user to approve the deposit and gas fee.
4. The contract records the deposit for `msg.sender`.
5. The user calls `withdraw` with an amount in wei.
6. The contract checks the balance, updates state, and transfers the Ether.
7. The user calls `getBalance` to verify the remaining recorded balance.

## Detailed Program Walkthrough

The complete program is:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Bank {
    mapping(address => uint256) private balances;
    bool private locked;

    event Deposit(address indexed account, uint256 amount);
    event Withdrawal(address indexed account, uint256 amount);

    modifier nonReentrant() {
        require(!locked, "Reentrant call");
        locked = true;
        _;
        locked = false;
    }

    function deposit() external payable {
        require(msg.value > 0, "Deposit must be greater than zero");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external nonReentrant {
        require(amount > 0, "Withdrawal must be greater than zero");
        require(amount <= balances[msg.sender], "Insufficient balance");

        balances[msg.sender] -= amount;

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");

        emit Withdrawal(msg.sender, amount);
    }

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
```

### 1. License and compiler version

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
```

The SPDX comment identifies the license. The `pragma` statement tells Remix which
Solidity compiler version is compatible with the program. Solidity `0.8.x` also
provides built-in checks for arithmetic underflow and overflow.

### 2. Contract declaration

```solidity
contract Bank {
```

This declares a contract named `Bank`. Deploying the contract creates a permanent
contract instance with its own blockchain address and Ether balance.

### 3. Account balance storage

```solidity
mapping(address => uint256) private balances;
```

The mapping stores an internal balance for every address:

```text
balances[userAddress] = amount in wei
```

If an address has never deposited, its mapping value is automatically `0`. The
mapping records ownership inside the bank's accounting system; it is separate from
the wallet balance shown in MetaMask.

The `private` keyword prevents other contracts and external users from directly
reading the mapping variable. The `getBalance` function provides the controlled
read operation.

### 4. Reentrancy lock

```solidity
bool private locked;
```

This Boolean stores whether a withdrawal is currently executing. Its default value is
`false`. It is used by the `nonReentrant` modifier to prevent nested withdrawals.

### 5. Events

```solidity
event Deposit(address indexed account, uint256 amount);
event Withdrawal(address indexed account, uint256 amount);
```

Events create searchable logs in transaction receipts. The `indexed` account field
allows block explorers and applications to filter deposits and withdrawals by address.
Events do not change balances and are not the same as storage variables.

### 6. The `nonReentrant` modifier

```solidity
modifier nonReentrant() {
    require(!locked, "Reentrant call");
    locked = true;
    _;
    locked = false;
}
```

The modifier performs four steps:

1. It checks that `locked` is `false`.
2. It changes `locked` to `true`.
3. The underscore (`_`) runs the body of the protected function.
4. It changes `locked` back to `false`.

If an external call tries to enter `withdraw` again before the first withdrawal
finishes, the first `require` fails and the nested call is rejected.

### 7. Deposit function

```solidity
function deposit() external payable {
    require(msg.value > 0, "Deposit must be greater than zero");
    balances[msg.sender] += msg.value;
    emit Deposit(msg.sender, msg.value);
}
```

`external` means the function is intended to be called from outside the contract.
`payable` allows Ether to be attached to the transaction.

When the student enters `0.01 ETH` in Remix, the blockchain represents it as:

```text
0.01 ETH = 10000000000000000 wei
```

The `require` statement rejects a zero-value deposit. Then `msg.value` is added to
the balance belonging to `msg.sender`, which is the MetaMask account that clicked
the `deposit` button. Finally, the `Deposit` event is recorded.

The deposit changes contract storage and transfers Ether to the contract, so it
requires MetaMask approval and gas.

### 8. Withdrawal function

```solidity
function withdraw(uint256 amount) external nonReentrant {
    require(amount > 0, "Withdrawal must be greater than zero");
    require(amount <= balances[msg.sender], "Insufficient balance");

    balances[msg.sender] -= amount;

    (bool success, ) = payable(msg.sender).call{value: amount}("");
    require(success, "Transfer failed");

    emit Withdrawal(msg.sender, amount);
}
```

The caller supplies `amount` in wei. For a `0.005 ETH` withdrawal, the input is:

```text
5000000000000000
```

The function first checks that the amount is positive and no greater than the
caller's recorded balance. It then decreases the balance before sending Ether.
This order follows the checks-effects-interactions pattern:

1. **Checks:** validate the amount and available balance.
2. **Effects:** reduce the recorded balance.
3. **Interactions:** send Ether to the caller.

The Ether is sent with:

```solidity
payable(msg.sender).call{value: amount}("");
```

`payable` indicates that the address can receive Ether. `call` returns a Boolean
success value, which is checked by the next `require`. If the transfer fails, the
transaction reverts.

The withdrawal is protected by `nonReentrant`, so another withdrawal cannot start
while the Ether transfer is in progress. A successful withdrawal produces a
`Withdrawal` event and requires gas.

### 9. Reading the user's balance

```solidity
function getBalance() external view returns (uint256) {
    return balances[msg.sender];
}
```

This function returns the internal balance of the account that calls it. The
`view` keyword guarantees that the function does not modify blockchain state.
Remix can call it without creating a transaction, so the read normally does not
require gas.

The result is a raw integer in wei. For example:

```text
5000000000000000 wei = 0.005 ETH
```

### 10. Reading the contract's total balance

```solidity
function getContractBalance() external view returns (uint256) {
    return address(this).balance;
}
```

`address(this)` represents the deployed `Bank` contract's own address. The
`.balance` property returns the total Ether held at that address in wei. This value
is the total contract-held Ether, while `getBalance()` returns only the caller's
internal allocation.

### 11. Complete practical example

Assume the account deposits `0.01 ETH`:

```text
balances[user] = 0.01 ETH
contract balance = 0.01 ETH
```

The account then withdraws `0.005 ETH`:

```text
balances[user] = 0.005 ETH
contract balance = 0.005 ETH
```

The wallet's actual balance also changes because it pays gas for both transactions.
Therefore, the wallet balance is not exactly the same as the internal bank balance.

If the account next tries to withdraw `0.01 ETH`, the contract compares the request
with the remaining `0.005 ETH` and reverts with **Insufficient balance**. No Ether is
transferred and the state change is cancelled.

### 12. Gas and transaction behavior

- Deployment stores the contract code and costs gas.
- `deposit` stores a new balance and receives Ether, so it costs gas.
- `withdraw` updates storage and sends Ether, so it costs gas.
- `getBalance` and `getContractBalance` only read data and normally cost no gas in
  Remix.
- A reverted transaction may still consume gas for the computation already performed.

This program demonstrates how a blockchain smart contract can enforce account
ownership, maintain balances, transfer Ether, and protect a withdrawal operation
against common reentrancy behavior.
