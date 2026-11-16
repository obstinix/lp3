# Practical 1: Install MetaMask and Study Ether Transaction Fees

## Aim

Install MetaMask, create or use a test account, connect it to Remix IDE, and observe
the Ether spent on a blockchain transaction.

## Requirements

- A modern web browser
- MetaMask browser extension
- Remix IDE: https://remix.ethereum.org/
- A supported Ethereum test network, preferably Sepolia
- Test ETH obtained from a reputable Sepolia faucet

## Important Safety Rules

- Use only a test account and test ETH for this practical.
- Never share your Secret Recovery Phrase or private key.
- Never enter the Secret Recovery Phrase into Remix, a faucet, or an unknown website.
- Verify the selected network and transaction details before approving a transaction.

## Procedure

1. Install the MetaMask extension from the official MetaMask website or the browser's
   official extension store.
2. Open MetaMask and select **Create a new wallet**, or import a dedicated test wallet.
3. Store the Secret Recovery Phrase offline in a secure place. Do not share it.
4. Copy the wallet's public address. This address can be used to receive test ETH.
5. Select the **Sepolia** test network in MetaMask. Do not use the deprecated Rinkeby
   network.
6. Open the Google Cloud Sepolia Faucet, sign in if required, and enter the MetaMask
   public address copied in Step 4. Request **0.05 Sepolia ETH** and wait for the
   transfer to confirm in MetaMask.
7. Open [Remix IDE](https://remix.ethereum.org/) in the browser. In the **File
   Explorers** panel, click **Create new file**, name it `SimpleStorage.sol`, and
   open the new file.
8. Enter this Solidity smart contract in `SimpleStorage.sol`:

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

9. Save the file using **Ctrl+S**. Open the **Solidity Compiler** panel from the
   left toolbar, select a compiler version compatible with `^0.8.20` (for example
   `0.8.20` or a newer `0.8.x` version), and click **Compile SimpleStorage.sol**.
   Confirm that the compiler shows a green success message.
10. Open the **Deploy & Run Transactions** panel. Set **Environment** to
    **Injected Provider - MetaMask**. When MetaMask opens, approve the connection.
11. In MetaMask, confirm the connection is using the **Sepolia** network and the
    correct BT practical account. If it shows Localhost or another network, cancel
    and switch MetaMask to Sepolia before reconnecting.
    Record the wallet's current Sepolia ETH balance as **Balance before deployment**.
12. In Remix, confirm that **Contract** is set to `SimpleStorage` and click
    **Deploy**. Review the deployment transaction and estimated gas fee in MetaMask,
    then click **Confirm**.
13. Wait until MetaMask and Remix show that the deployment transaction is confirmed.
    Expand the deployed contract in Remix and record its contract address. In
    MetaMask, open **Activity**, select the deployment transaction, and copy its
    transaction hash.
14. After deployment is confirmed, record the new wallet balance as **Balance after
    deployment**.
15. In the deployed contract section in Remix, use the `getValue` button to read the
    current value. Enter a value such as `25` in the `setValue` input and click
    **setValue**. Approve this second transaction in MetaMask. Record its transaction
    hash and wait for confirmation. Click `getValue` again to verify that the result
    is `25`.
16. Calculate the approximate Ether spent on deployment:

    `Ether spent = balance before deployment - balance after deployment`

    If you also use `setValue`, calculate its cost separately using the balance
    immediately before and after that transaction.

17. Find the transaction details and calculate the fee:
    - In MetaMask, open **Activity** and select the deployment or `setValue`
      transaction. Open **View on block explorer**. Alternatively, open a Sepolia
      block explorer and paste the transaction hash into its search box.
    - On the transaction details page, find **Gas Used**. This is the amount of
      computational work consumed by the transaction.
    - Find **Gas Price** or **Effective Gas Price**. This is usually displayed in
      Gwei. If the explorer displays a value in Wei, convert it using:

      `1 ETH = 1,000,000,000 Gwei`

    - Find **Transaction Fee** or **Txn Fee**. The explorer normally displays this
      directly in ETH.
    - If the fee is not displayed, calculate it using:

      `Transaction fee (ETH) = Gas used × Gas price (Gwei) ÷ 1,000,000,000`

    - Record the gas used, gas price, and transaction fee separately for the
      deployment and `setValue` transactions. Compare the fee with the decrease in
      the MetaMask ETH balance. Small differences can occur if another transaction
      changed the balance.

## Observation Table

| Item | Value |
|---|---|
| Network | |
| Wallet address | |
| Balance before transaction | |
| Balance after transaction | |
| Transaction hash | |
| Gas used | |
| Gas price | |
| Transaction fee in ETH | |

## Result

MetaMask was installed and connected to Remix. A smart-contract transaction was
submitted on a test network, and the Ether transaction fee was observed and recorded.