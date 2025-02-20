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
   git clone https://github.com/YOUR_USERNAME/dsre-blockchain.git
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