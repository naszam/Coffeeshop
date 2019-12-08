# Coffeeshop

Coffeeshop Smart Contract

Project Setup
============

Clone this GitHub repository. The [Coffeeshop.sol](./contracts/Coffeeshop.sol) file in the contracts directory is the smart contract.

# Steps to compile and deploy Coffeeshop.sol

  - Global dependencies
    - Truffle & Ganache:
    ```sh
    $ npm install -g truffle ganache-cli
    ```
## Running the project with local test network (ganache-cli)
    
   - Start ganache-cli with the following command:
     ```sh 
     $ ganache-cli
     ``` 
   - Compile the smart contract using Truffle with the following command:
     ```sh
     $ truffle compile
     ```
   - Deploy the smart contract using Truffle & Ganache with the following command:
     ```sh
     $ truffle migrate
     ```
     
## Deploying on Rinkeby's Testnet
  - Get an Ethereum Account on Metamask. 
  - On the landing page, click “Get Chrome Extension.”
  - Create a .secret file cointaining the menomic.
    
  - Install the Truffle HD wallet provider with the following command:
    ```sh
    $ npm install @truffle/hdwallet-provider
    ```
  - Deploy the smart contract using Truffle & Infura with the following command:
    ```sh
    $ truffle migrate --network rinkeby
    ```
 ## I've deployed the smart contract on Rinkeby's Testnet (https://www.rinkeby.io/#explorer):
   - Transaction Hash: 0x1e38ff820a8415df089743472affc87b01994ec67a9871cfb9dcaa916571ccf7
   - Contract Address: 0x1624Ed88C02a6bD85752528acbAEDD812B5f9b19
