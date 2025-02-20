# Decentralized Study Resource Exchange (DSRE)

## Overview
DSRE is a decentralized platform for students to securely share, trade, and collaborate on study resources using blockchain technology. It utilizes Ethereum smart contracts built with Solidity and Hardhat.

This project includes:
- **DSREToken:** An ERC-20 token for transactions within the platform
- **StudyResourceNFT:** An ERC-721 contract for tokenizing study materials as NFTs
- **DSREMarketplace:** A marketplace for listing and trading study resources

## Table of Contents
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Environment Setup](#environment-setup)
- [Compile Contracts](#compile-contracts)
- [Run Local Blockchain](#run-local-blockchain)
- [Deploy Contracts](#deploy-contracts)
- [Interact with Contracts](#interact-with-contracts)
- [Useful Commands](#useful-commands)
- [Project Structure](#project-structure)
- [Troubleshooting](#troubleshooting)
- [License](#license)
- [Contributing](#contributing)
- [Contact](#contact)

## Prerequisites
Ensure you have the following installed:
- **Node.js** (v16.x.x or later) - [Download](https://nodejs.org)
- **MetaMask Wallet** - [Download](https://metamask.io)
- **Infura Account** - [Register](https://infura.io) for an API key
- **Hardhat** - Installed as a dependency in this project
- **Git** - To clone the repository

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/rohanmhetar/dsre-blockchain.git
   cd dsre-blockchain
   ```

2. Install dependencies:
   ```sh
   npm install
   ```

3. Install OpenZeppelin contracts:
   ```sh
   npm install @openzeppelin/contracts
   ```

## Environment Setup

1. Create a `.env` file in the project root:
   ```ini
   INFURA_API_KEY=your_infura_api_key_here
   PRIVATE_KEY=your_private_key_here
   ```

2. Get your Infura API Key:
   - Sign up at Infura and create a new project
   - Copy the Project ID and use it as your `INFURA_API_KEY`

3. Get your Private Key:
   - Open MetaMask
   - Go to Settings > Security & Privacy > Export Private Key
   - Copy the private key (without the 0x prefix)

⚠️ **WARNING:**
- NEVER share your private key publicly
- NEVER commit the `.env` file to GitHub

## Compile Contracts

Compile the Solidity smart contracts:
```sh
npx hardhat compile
```

## Run Local Blockchain

Start a local Ethereum blockchain:
```sh
npx hardhat node
```

This will start a local blockchain on `http://127.0.0.1:8545` with test accounts.

## Deploy Contracts

### Local Deployment
```sh
npx hardhat run scripts/deploy.js --network localhost
```

### Goerli Testnet Deployment
Requirements:
- Goerli ETH in your MetaMask account
- Properly configured `.env` file

Deploy command:
```sh
npx hardhat run scripts/deploy.js --network goerli
```

## Interact with Contracts

Open Hardhat's console:
```sh
npx hardhat console --network localhost
```

Example interaction:
```javascript
const [owner, addr1] = await ethers.getSigners();
const token = await ethers.getContractAt("DSREToken", "DEPLOYED_TOKEN_ADDRESS");
const balance = await token.balanceOf(owner.address);
console.log("Owner Balance:", balance.toString());
```

# **How to Use the Decentralized Study Resource Exchange (DSRE) System**  

We'll cover:  
1. [Understanding the System](#understanding-the-system)  
2. [Requirements and Setup](#requirements-and-setup)  
3. [Minting Study Resource NFTs](#minting-study-resource-nfts)  
4. [Listing NFTs on the Marketplace](#listing-nfts-on-the-marketplace)  
5. [Buying NFTs from the Marketplace](#buying-nfts-from-the-marketplace)  
6. [Withdrawing Earnings](#withdrawing-earnings)  
7. [Advanced Interactions and Tips](#advanced-interactions-and-tips)  

---

## **Understanding the System**  

### **What is DSRE?**  
DSRE is a decentralized marketplace where students can:  
- **Mint study resources** as NFTs (e.g., notes, flashcards, study guides).  
- **List these NFTs** for sale on the marketplace.  
- **Buy NFTs** using the DSRE Token, a custom ERC-20 token for transactions.  

### **Key Components:**  
- **DSREToken:** An ERC-20 token used for buying and selling study resources.  
- **StudyResourceNFT:** An ERC-721 contract for minting NFTs representing study materials.  
- **DSREMarketplace:** The marketplace for listing, buying, and selling NFTs.  

### **User Roles and Actions:**  
- **Seller:** Mint NFTs and list them for sale.  
- **Buyer:** Purchase NFTs from the marketplace.  
- **Admin (Owner):** Deploy contracts and manage the marketplace.  

---

## **Requirements and Setup**  

### **1. Install MetaMask**  
- Install the MetaMask browser extension from [MetaMask.io](https://metamask.io).  
- Create an account or import an existing one.  
- Ensure you're on the **Goerli Test Network**.  

### **2. Get Goerli ETH**  
- You need Goerli ETH to pay gas fees on the testnet.  
- Visit a faucet and request Goerli ETH:
  - [Alchemy Faucet](https://goerlifaucet.com)
  - [Paradigm Faucet](https://faucet.paradigm.xyz)  

### **3. Add DSRE Token to MetaMask**  
After deploying the DSREToken contract, add it to MetaMask:  
- Go to MetaMask and select **Import Tokens**.  
- Enter the **DSRE Token Contract Address**.  
- MetaMask should auto-detect the symbol `DSRE`.  
- Click **Add Custom Token**.  

---

## **Minting Study Resource NFTs**  

### **Step 1: Open Hardhat Console**  
```sh
npx hardhat console --network goerli
```

This opens an interactive console connected to the Goerli testnet.  

---

### **Step 2: Connect to the StudyResourceNFT Contract**  
```js
const nftAddress = "YOUR_NFT_CONTRACT_ADDRESS";
const StudyResourceNFT = await ethers.getContractAt("StudyResourceNFT", nftAddress);
```

Replace `YOUR_NFT_CONTRACT_ADDRESS` with the actual contract address you received during deployment.  

---

### **Step 3: Mint an NFT**  
To mint a new study resource NFT, use the `mintResource()` function.  

Example:  
```js
const tx = await StudyResourceNFT.mintResource("ipfs://QmExampleURI");
await tx.wait();
```

**Explanation:**  
- The argument is an IPFS URI pointing to the resource metadata.  
- Use [Pinata](https://pinata.cloud) or [NFT.Storage](https://nft.storage) to upload your resource and get an IPFS link.  

---

### **Step 4: Verify Ownership**  
After minting, verify that you own the newly minted NFT:  
```js
const owner = await StudyResourceNFT.ownerOf(1);  // Token ID starts at 1
console.log("Owner Address:", owner);
```

You should see your MetaMask wallet address as the owner.  

---

## **Listing NFTs on the Marketplace**  

### **Step 1: Connect to the Marketplace Contract**  
```js
const marketplaceAddress = "YOUR_MARKETPLACE_CONTRACT_ADDRESS";
const DSREMarketplace = await ethers.getContractAt("DSREMarketplace", marketplaceAddress);
```

Replace `YOUR_MARKETPLACE_CONTRACT_ADDRESS` with your deployed marketplace address.  

---

### **Step 2: Approve the Marketplace to Transfer Your NFT**  
Before listing, you must approve the marketplace to transfer the NFT:  

```js
const tokenId = 1;
const approveTx = await StudyResourceNFT.approve(marketplaceAddress, tokenId);
await approveTx.wait();
```

This allows the marketplace to move your NFT once it's sold.  

---

### **Step 3: List the NFT for Sale**  
```js
const price = ethers.utils.parseUnits("10", 18);  // Price in DSRE Tokens
const listTx = await DSREMarketplace.listResource(tokenId, price);
await listTx.wait();
```

**Explanation:**  
- The price is set in DSRE Tokens, using 18 decimal places (standard for ERC-20 tokens).  
- In this example, the NFT is listed for `10 DSRE`.  

---

### **Step 4: Confirm the Listing**  
Verify the listing by calling the marketplace's mapping:  
```js
const listing = await DSREMarketplace.listings(tokenId);
console.log("Listing Details:", listing);
```

You should see details like the price, seller address, and sale status.  

---

## **Buying NFTs from the Marketplace**  

### **Step 1: Approve DSRE Tokens for Purchase**  
The buyer must approve the marketplace to spend DSRE Tokens on their behalf:  

```js
const dsreTokenAddress = "YOUR_DSRE_TOKEN_CONTRACT_ADDRESS";
const DSREToken = await ethers.getContractAt("DSREToken", dsreTokenAddress);

const amount = ethers.utils.parseUnits("10", 18);  // Same price as the listing
const approveTx = await DSREToken.approve(marketplaceAddress, amount);
await approveTx.wait();
```

---

### **Step 2: Purchase the NFT**  
```js
const buyTx = await DSREMarketplace.buyResource(tokenId);
await buyTx.wait();
```

**Explanation:**  
- The marketplace checks the approval and transfers the DSRE Tokens to the seller.  
- The NFT ownership is transferred to the buyer.  

---

### **Step 3: Verify Ownership Transfer**  
```js
const newOwner = await StudyResourceNFT.ownerOf(tokenId);
console.log("New Owner Address:", newOwner);
```

The buyer's wallet address should now be the owner.  

---

## **Withdrawing Earnings**  

As a seller, you can withdraw your earnings accumulated from sales:  

```js
const withdrawTx = await DSREMarketplace.withdrawEarnings();
await withdrawTx.wait();
```

The DSRE Tokens are transferred from the marketplace contract to your wallet.  

---

## **Advanced Interactions and Tips**  

### **1. Viewing Token URI**  
View the metadata URI of an NFT:  
```js
const tokenURI = await StudyResourceNFT.tokenURI(tokenId);
console.log("Token URI:", tokenURI);
```

### **2. Checking Token Balances**  
Check your DSRE Token balance:  
```js
const balance = await DSREToken.balanceOf("YOUR_WALLET_ADDRESS");
console.log("Balance:", ethers.utils.formatUnits(balance, 18), "DSRE");
```

### **3. Canceling a Listing**  
If you want to remove a listing:  
```js
const cancelTx = await DSREMarketplace.cancelListing(tokenId);
await cancelTx.wait();
```

---

## **Tips for a Smooth Experience**  
- **Double-check Contract Addresses:** Always use the correct addresses for the deployed contracts.  
- **Confirm Transactions:** Wait for transaction confirmations before performing the next action.  
- **Use Etherscan:** Track transactions and contract interactions on [Goerli Etherscan](https://goerli.etherscan.io).  

---
