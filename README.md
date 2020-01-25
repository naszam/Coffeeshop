# Coffeeshop

Coffeeshop Smart Contract

Project Setup
============

Clone this GitHub repository.

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
    
  - Install Truffle HD Wallet Provider:
    ```sh
    $ npm install -g @truffle/hdwallet-provider
    ```
  - Deploy the smart contract using Truffle & Infura with the following command:
    ```sh
    $ truffle migrate --network rinkeby
    ```
 ## I've deployed the smart contract on [Rinkeby's Testnet](https://www.rinkeby.io/#explorer):
 - Contract Address: 0x1624Ed88C02a6bD85752528acbAEDD812B5f9b19
