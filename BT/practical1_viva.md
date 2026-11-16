# Assignment 1: MetaMask and Ether Transaction Fees

## Viva Questions and Answers

### 1. What is MetaMask?
MetaMask is a browser extension and wallet that lets users manage Ethereum accounts
and interact with decentralized applications (dApps).

### 2. Why is MetaMask used in this practical?
It provides an Ethereum wallet and allows us to approve, sign, and view blockchain
transactions from a browser.

### 3. What is a cryptocurrency wallet?
A wallet is an application that manages blockchain accounts and their cryptographic
keys. It does not store coins physically; it signs transactions for an account.

### 4. What is a public address?
A public address identifies an account on the blockchain. It may be shared to receive
funds, but it does not reveal the account's private key.

### 5. What is a private key or Secret Recovery Phrase?
It is the secret used to control and recover an account. It must never be shared or
entered into an untrusted website.

### 6. What is Ether?
Ether (ETH) is Ethereum's native cryptocurrency. It is used to transfer value and pay
transaction fees.

### 7. What is a gas fee?
Gas is the computational work required to execute an Ethereum transaction. The gas fee
is paid in ETH and generally depends on the work required and network demand.

### 8. Why are transaction fees required?
Fees compensate validators for processing and securing transactions and help prevent
network abuse.

### 9. What is a test network?
A test network is a blockchain network used for development and learning. Its tokens
are intended to have no real monetary value.

### 10. What is Rinkeby?
Rinkeby was an Ethereum test network, but it has been deprecated. Use a currently
supported test network such as Sepolia when performing this practical.

### 11. What is Remix IDE?
Remix is a browser-based IDE used to write, compile, deploy, and interact with Solidity
smart contracts.

### 12. What is Solidity?
Solidity is a programming language for writing smart contracts that run on
Ethereum-compatible blockchains.

### 13. What is a smart contract?
A smart contract is a program deployed on a blockchain. Its functions execute according
to its code when a transaction or call invokes them.

### 14. What happens when a contract is deployed?
The contract code is compiled into bytecode and submitted in a blockchain transaction.
After confirmation, the contract receives an address and can be called.

### 15. What is the difference between a transaction and a read-only call?
A transaction changes blockchain state and usually requires a signature and gas fee. A
read-only call only reads state and normally does not require gas.

### 16. What is the role of MetaMask during deployment?
MetaMask connects Remix to the selected network, shows the estimated fee, and asks the
user to approve and sign the deployment transaction.

### 17. How can the transaction cost be studied?
Record the ETH balance before and after the transaction. The difference is the amount
spent, subject to any balance changes from other transactions.

### 18. What is the conclusion of this practical?
MetaMask was installed and used with a test network to study an Ethereum account,
Ether, smart-contract interaction, and transaction fees.

## Smart Contract Code Explanation

The following `SimpleStorage` contract is written in Solidity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleStorage {
    uint256 private storedValue;

    function setValue(uint256 value) public {
        storedValue = value;
    }

    function getValue() public view returns (uint256) {
        return storedValue;
    }
}
```

### 1. License declaration

```solidity
// SPDX-License-Identifier: MIT
```

This identifies the license under which the contract code is released. It also removes
the license warning shown by Remix.

### 2. Solidity version

```solidity
pragma solidity ^0.8.20;
```

This tells the compiler to use Solidity version `0.8.20` or a compatible later `0.8.x`
version. The caret (`^`) allows compatible compiler updates within the 0.8 release
series.

### 3. Contract declaration

```solidity
contract SimpleStorage {
```

This creates a smart contract named `SimpleStorage`. A contract is similar to a class
that contains data and functions, but it is deployed and executed on the blockchain.

### 4. Stored variable

```solidity
uint256 private storedValue;
```

This declares an unsigned 256-bit integer named `storedValue`.

- `uint256` stores a non-negative whole number.
- `private` means the variable is accessed directly only inside this contract.
- The default value is `0`.

### 5. Updating the value

```solidity
function setValue(uint256 value) public {
    storedValue = value;
}
```

The `setValue` function accepts a number and stores it in `storedValue`.

- `function` declares a function.
- `setValue` is the function name.
- `uint256 value` is the input parameter.
- `public` allows external users and applications to call the function.

Calling `setValue(25)` changes blockchain state. Therefore, MetaMask asks for approval
and a transaction fee is charged.

### 6. Reading the value

```solidity
function getValue() public view returns (uint256) {
    return storedValue;
}
```

The `getValue` function returns the current value of `storedValue`.

- `view` means the function only reads blockchain data.
- `returns (uint256)` specifies that the function returns an unsigned integer.
- `return storedValue` sends the stored value back to the caller.

Calling `getValue` does not change blockchain state, so it normally does not require a
MetaMask approval or gas fee when called from Remix.

### 7. Gas behavior in this practical

- Deploying `SimpleStorage` stores the contract on Sepolia and costs gas.
- Calling `setValue(25)` changes the stored value and costs gas.
- Calling `getValue()` only reads the value and normally costs no gas.
- The transaction fee can be checked in MetaMask or on a Sepolia block explorer.
