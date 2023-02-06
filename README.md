# Bootcamp hardhat project
Update: added code for goerli testnet deployment
Try in the console where you downloaded this project:
```
npm install
npm i @openzeppelin/contracts
npx hardhat compile
npx hardhat test
```
## exercises
* update the test suite to work with the latest MessageStoreVulnerable.sol contract
* use the included attacker.sol contract to test for _and fix_ the vulnerabiilty in MessageStoreVulnerable.sol

# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```
