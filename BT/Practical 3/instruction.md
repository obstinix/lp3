# Practical 3: Bank Account Smart Contract

## Aim

Write, deploy, and test a Solidity smart contract on the Sepolia test network that
supports deposits, withdrawals, and balance checking for individual accounts.

## Objectives

After completing this practical, the student will be able to:

1. Explain the structure and purpose of a smart contract.
2. Use a Solidity mapping to maintain individual account balances.
3. Deposit test Ether into a smart contract.
4. Withdraw Ether only when the caller has sufficient balance.
5. Read an account balance from the blockchain.
6. Explain checks-effects-interactions and reentrancy protection.

## Theory

A smart contract is a program deployed on a blockchain. It stores data in persistent
state and executes functions when users submit transactions or read public data.

This bank contract maintains a separate internal balance for each Ethereum address.
The actual Ether is held by the contract address, while the mapping records how much
of that Ether belongs to each depositor. A user can withdraw only the amount recorded
for their own address.

The contract uses `msg.sender` to identify the account making the call and `msg.value`
to identify the amount of Ether attached to a payable transaction. Deposits and
withdrawals change blockchain state and require gas. Balance functions are read-only
and normally do not require gas when called from Remix.

## Requirements

- A modern web browser
- MetaMask with the BT practical test account
- Sepolia test network
- Sepolia test ETH
- Remix IDE: https://remix.ethereum.org/

## Important Safety Rules

- Use only Sepolia test ETH; never use real Ether for this practical.
- Never share the Secret Recovery Phrase or private key.
- Verify that Remix and MetaMask are connected to Sepolia, not Localhost or Mainnet.
- Enter withdrawal amounts in wei when Remix asks for a `uint256`.
- Use a small test amount and review every transaction before confirming it.

## Smart Contract Code

Create a file named `Bank.sol` in Remix and enter:

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

## Procedure

### A. Create and compile the contract

1. Open [Remix IDE](https://remix.ethereum.org/).
2. In **File Explorers**, click **Create new file** and name it `Bank.sol`.
3. Enter the contract code shown above and save it with **Ctrl+S**.
4. Open **Solidity Compiler** from the left toolbar.
5. Select compiler version `0.8.20` or another compatible `0.8.x` version.
6. Click **Compile Bank.sol** and confirm that compilation succeeds.

### B. Connect Remix to MetaMask

7. Open **Deploy & Run Transactions**.
8. Set **Environment** to **Injected Provider - MetaMask**.
9. Approve the connection request in MetaMask.
10. Confirm that MetaMask and Remix show the Sepolia network and the correct account.
    If Localhost or another network appears, cancel and switch MetaMask to Sepolia.
11. Confirm that **Contract** is set to `Bank`.
12. Click **Deploy**, review the gas estimate, and click **Confirm** in MetaMask.
13. Wait for confirmation and expand the deployed `Bank` contract in Remix.
14. Record the deployed contract address and deployment transaction hash.

### C. Deposit test Ether

15. In MetaMask, record the wallet balance before the deposit.
16. In Remix's **Deploy & Run Transactions** panel, locate the **Value** field.
17. Select **wei** from the unit dropdown and enter
    `10000000000000000`. This is exactly `0.01 ETH` and is the amount attached to
    the deposit transaction. Using wei avoids decimal-input issues in Remix. You may
    alternatively select **Gwei** and enter `10000000`, which is also `0.01 ETH`.
18. Click the red **deposit** button. Review the amount and gas fee in MetaMask and
    click **Confirm**.
19. Wait for the transaction to confirm. Record its transaction hash.
20. Reset the **Value** field to `0` after the deposit so it is not accidentally
    attached to another transaction.
21. Click **getBalance**. The result is returned as a raw integer in **wei**, because
    Solidity stores Ether amounts in wei. Convert it to ETH for reporting if needed.
    For reference:

    `0.01 ETH = 10,000,000,000,000,000 wei`

22. Click **getContractBalance** and confirm that the contract's Ether balance
    includes the deposited amount.

### D. Withdraw part of the balance

23. To withdraw `0.005 ETH`, convert it to wei:

    `0.005 ETH = 5,000,000,000,000,000 wei`

24. Enter `5000000000000000` in the `withdraw` input field.
25. Ensure the **Value** field is `0`, then click **withdraw**.
26. Review the withdrawal and gas details in MetaMask and click **Confirm**.
27. Wait for confirmation and record the withdrawal transaction hash.
28. Click **getBalance** again. The expected contract balance for this account is
    approximately `0.005 ETH` in wei, excluding any other deposits or withdrawals.
29. Click **getContractBalance** and confirm that the contract balance decreased by
    the withdrawal amount.

### E. Test insufficient-balance protection

30. Enter an amount greater than the account's recorded balance, such as
    `10000000000000000` wei if the remaining balance is `0.005 ETH`.
31. Click **withdraw** and observe that the transaction is rejected with
    **Insufficient balance**. Do not approve a transaction that does not match the
    intended test.

### F. Record transaction details

32. Open each deployment, deposit, and withdrawal transaction in a Sepolia block
    explorer using its transaction hash.
33. Record the status, gas used, gas price, and transaction fee in ETH.
34. Compare the balance returned by `getBalance` with the deposit and withdrawal
    operations.

## Observation Table

| Item | Value |
|---|---|
| Network | Sepolia |
| Deployed contract address | |
| Deployment transaction hash | |
| Account address | |
| Balance before deposit | |
| Deposit amount | 0.01 ETH |
| Deposit transaction hash | |
| Balance after deposit | |
| Withdrawal amount | 0.005 ETH |
| Withdrawal transaction hash | |
| Balance after withdrawal | |
| Gas used | |
| Gas price | |
| Transaction fee in ETH | |

## Result

A bank smart contract was compiled and deployed on the Sepolia test network.
Deposits, withdrawals, account-balance checks, and insufficient-balance protection
were tested successfully.
