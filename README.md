
# Smart Contract Proxy

A project that creates proxies for upgradeable smart contracts by only adding the upgraded smart contract.


A proxy preserves original contract storage state. "Upgrading" a contract does not mean we can change the original state of it or any of its declared types, in fact, we are not allowed to. We can, however, add new functions and new variables.


# 


## Acknowledgements

 - [Basic Tutorial on how to create a Proxy](https://www.chainshot.com/article/how-to-make-contracts-upgradeable)


## Installation

Download the repository

Download basic dependencies with npm

```bash
  npm init -y
  npm install --save-dev hardhat

  npm install @nomiclabs/hardhat-ethers @nomiclabs/hardhat-waffle @openzeppelin/contracts-upgradeable @openzeppelin/hardhat-upgrades
  npm install @nomiclabs/hardhat-etherscan@3.0.1

  npm install dotenv
  npx hardhat
```

Depending on your smart contract you might 
need these aditional dependencies

```bash
  npm i @openzeppelin/contracts-upgradeable
```
## Troubleshooting

Based on my experience you might get certain errors when uploading/upgrading your smart contract

touch is not recognized as an internal or external command

```bash
  npm install touch-cli -g
```

An unexpected error occurred:

[Error: ENOENT: no such file or directory, open '.\artifacts\build-info\2f5b41288986dca290d9139587ff8570.json'] {
  
  errno: -4058,
  
  code: 'ENOENT',
  
  syscall: 'open',
  
  path: '.\\artifacts\\build-info\\2f5b41288986dca290d9139587ff8570.json'

PS > npx hardhat verify --network mumbai 0x705148ff1E980B9E0f808fA5d25cA00706c29Cc1

```bash
  npx hardhat clean
```