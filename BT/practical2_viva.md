# Assignment 2: MetaMask Wallet for Crypto Transactions

## Viva Questions and Answers

### 1. What is MetaMask?
MetaMask is a non-custodial cryptocurrency wallet available as a browser extension
and mobile application. It manages blockchain accounts and connects users to
decentralized applications.

### 2. What does non-custodial mean?
It means the user controls the wallet credentials. MetaMask does not hold the user's
funds in a central account or recover a lost Secret Recovery Phrase.

### 3. What is a cryptocurrency wallet?
A wallet is software that manages blockchain accounts and cryptographic keys. It
allows the user to view balances and sign transactions.

### 4. Does MetaMask physically store Ether?
No. Ether remains recorded on the blockchain. MetaMask stores or uses the credentials
needed to control the account and displays the account's blockchain balance.

### 5. What is a public address?
A public address identifies an account on a blockchain. It can be shared to receive
funds and normally begins with `0x` on Ethereum-compatible networks.

### 6. What is a private key?
A private key is a secret cryptographic value used to sign transactions. Anyone who
obtains it may control the associated account.

### 7. What is a Secret Recovery Phrase?
It is a sequence of words that can restore a wallet and its accounts. It must be
written down securely and never shared or entered into an untrusted website.

### 8. What is the difference between a wallet password and a Secret Recovery Phrase?
The password unlocks MetaMask on a particular device. The Secret Recovery Phrase
restores the wallet and is more sensitive; losing it may permanently prevent recovery.

### 9. What is a blockchain account?
An account is identified by a public address and controlled by a private key. It can
hold assets and sign transactions.

### 10. What is a test network?
A test network is used for development and education. Its tokens, such as Sepolia ETH,
are intended to have no real monetary value.

### 11. Why is Sepolia used in this practical?
Sepolia provides a supported Ethereum test environment where transactions can be
performed without spending real Ether.

### 12. What is a dApp?
A decentralized application is an application that interacts with blockchain
contracts or data. MetaMask acts as the user's wallet and transaction-signing
interface for many dApps.

### 13. How does MetaMask connect to a dApp?
The dApp requests access through the browser wallet provider. MetaMask asks the user
to approve account access and then displays transaction requests for the user to
review and sign.

### 14. What is web3.js?
web3.js is a JavaScript library that helps applications communicate with Ethereum
nodes and smart contracts. Modern applications may also use other provider libraries
and the browser's `window.ethereum` provider.

### 15. What is a blockchain transaction?
A transaction is a signed request that changes blockchain state, such as transferring
Ether or calling a state-changing smart-contract function.

### 16. What information should be checked before sending Ether?
Check the selected network, recipient address, amount, estimated gas fee, and total
amount. A confirmed transaction normally cannot be reversed.

### 17. What is a gas fee?
Gas is the computational work needed to process a transaction. The gas fee is paid in
the network's native currency, which is ETH on Sepolia.

### 18. Why does sending Ether require gas?
Validators must process and secure the transaction. The fee compensates them and
helps prevent spam on the network.

### 19. What is the difference between the amount sent and the transaction fee?
The amount sent goes to the recipient. The transaction fee is paid separately to
process the transaction and is deducted from the sender's balance.

### 20. What is a transaction hash?
A transaction hash is a unique identifier for a blockchain transaction. It can be
used to find the transaction status and details in a block explorer.

### 21. What is a block explorer?
A block explorer is a website used to inspect public blockchain data, including
addresses, transactions, blocks, gas usage, and confirmation status.

### 22. What happens when a MetaMask transaction is confirmed?
MetaMask signs the transaction with the account's private key and broadcasts it.
After validators include it in a block, the transaction becomes confirmed.

### 23. Can a public address be shared?
Yes. A public address is intended for receiving funds. However, sharing it can reveal
the account's public transaction history.

### 24. What happens if the Secret Recovery Phrase is shared?
An attacker can restore the wallet and transfer its assets. The phrase should be
treated like the master key to the wallet.

### 25. What is the conclusion of this practical?
A MetaMask wallet was created and used on Sepolia to receive and send test Ether.
The public address, transaction confirmation, transaction hash, and gas fee were
studied.

## Transaction Flow Summary

1. The sender enters the recipient's public address and amount.
2. MetaMask estimates the gas fee and shows the transaction details.
3. The user checks the network, recipient, amount, and fee.
4. MetaMask signs and broadcasts the transaction after approval.
5. Validators process the transaction and include it in a block.
6. The transaction hash is used to verify the result in a block explorer.
