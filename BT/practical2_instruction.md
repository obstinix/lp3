# Practical 2: Create a MetaMask Wallet for Crypto Transactions

## Aim

Create and configure a MetaMask wallet, receive test Ether, and perform a crypto
transaction on the Sepolia test network.

## Objectives

After completing this practical, the student will be able to:

1. Explain the purpose of MetaMask.
2. Create and manage an Ethereum-compatible wallet.
3. Identify a public wallet address and protect private credentials.
4. Receive and send test Ether.
5. Understand transaction confirmation and gas fees.
6. Explain how MetaMask connects users to decentralized applications (dApps).

## Theory

MetaMask is a non-custodial cryptocurrency wallet available as a browser extension
and mobile application. It manages blockchain accounts and allows users to connect
to decentralized applications.

MetaMask does not store cryptocurrency physically. It stores or protects the
cryptographic credentials used to control blockchain accounts and sign transactions.
The public address can be shared to receive funds, but the private key and Secret
Recovery Phrase must remain secret.

MetaMask can connect a dApp to an Ethereum-compatible network. When a dApp requests
an operation, MetaMask displays the account, network, recipient, amount, and
estimated gas fee. The user must review and approve the transaction before it is
signed and broadcast.

MetaMask originally used web3.js and related provider APIs to allow browser
applications to communicate with blockchain nodes and smart contracts. Modern dApps
use provider APIs such as `window.ethereum` to request accounts, read blockchain
data, and ask MetaMask to sign transactions.

## Requirements

- A modern web browser
- MetaMask browser extension
- A dedicated test wallet
- Sepolia test network
- Sepolia test ETH
- A second test account or a classmate's test wallet address for the transfer

## Important Safety Rules

- Use only a test wallet and Sepolia test ETH.
- Never share the Secret Recovery Phrase or private key.
- Never type secret wallet credentials into a website, form, or chat.
- Share only the public address when receiving funds.
- Verify the recipient address, network, amount, and gas fee before confirming.
- Testnet ETH has no real monetary value and must not be purchased.

## Procedure

### A. Install MetaMask and create a wallet

1. Install MetaMask only from the official MetaMask website or the browser's
   official extension store.
2. Open the MetaMask extension and click **Get Started**.
3. Select **Create a new wallet**.
4. Create a password for unlocking MetaMask on the current device.
5. Reveal the Secret Recovery Phrase and write it down offline in the correct order.
6. Complete MetaMask's phrase confirmation step.
7. Open the wallet and note the account name and public address.
8. Never share the Secret Recovery Phrase or private key. The public address may be
   copied using the copy icon beside the account address.

### B. Select Sepolia and receive test ETH

9. Open the network selector at the top of MetaMask and select **Sepolia**. Enable
   **Show test networks** if necessary. Do not select Localhost or deprecated Rinkeby.
10. Open the Google Cloud Sepolia Faucet and sign in if required.
11. Enter the wallet's public address in the faucet. Check that the address belongs
    to the test account and does not contain typing errors.
12. Request **0.05 Sepolia ETH** and wait for the transfer to confirm.
13. Return to MetaMask, confirm that Sepolia is selected, and verify that the test
    ETH balance has increased.
14. Record the wallet address, network, and received amount.

### C. Prepare the recipient

15. Use another test account as the recipient. This may be a second account created
    in MetaMask or a classmate's test wallet.
16. Copy the recipient's public address. Confirm it begins with `0x` and verify the
    complete address using a trusted method before sending.
17. Do not use a real-money account or send funds to an unknown address.

### D. Send test Ether

18. In MetaMask, select the **Send** button.
19. Paste the recipient's public address into the recipient field.
20. Select the Sepolia network if MetaMask asks for a network.
21. Enter a small test amount, such as `0.001` Sepolia ETH.
22. Review the recipient address, amount, estimated gas fee, and total amount.
23. Click **Confirm** to sign and broadcast the transaction.
24. Wait for the transaction status to change from pending to confirmed.
25. Open **Activity**, select the transaction, and record its transaction hash.
26. Give the transaction hash to the recipient so it can be checked on a Sepolia
    block explorer.

### E. Verify the transaction

27. Open the transaction in a Sepolia block explorer using its transaction hash.
28. Confirm the sender address, recipient address, transferred amount, status,
    gas used, gas price, and transaction fee.
29. Check that the recipient's Sepolia balance increased by the transferred amount.
30. Check that the sender's balance decreased by the transferred amount plus the
    transaction fee.

## Observation Table

| Item | Value |
|---|---|
| Wallet account name | |
| Sender public address | |
| Recipient public address | |
| Network | Sepolia |
| Balance before sending | |
| Amount sent | |
| Gas used | |
| Gas price | |
| Transaction fee in ETH | |
| Balance after sending | |
| Transaction hash | |
| Transaction status | |

## Result

A MetaMask wallet was created and configured on the Sepolia test network. Test Ether
was received from a faucet and sent to another test account. The transaction,
confirmation status, and gas fee were observed using MetaMask and a Sepolia block
explorer.
