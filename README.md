# OmniLido

Deposit ETH to Lido From Any Chain

## Diagram
![Screenshot 2023-05-16 at 4 41 58 PM](https://github.com/Gajesh2007/OmniLido/assets/26431906/90d50fb6-5f1f-45e9-9421-a7058b15bfb3)

## How To Deploy

- Add Your Private Keys to `hardhat.config.js` OR add it your .env file & import it to `hardhat.config.js`
- Add RPC Endpoints for both the chains
- Add All The IDO, LZ & Stargate Details in `scripts/sourceDeploy.js` & `scripts/destinationDeploy.js` 
- Deploy Destination Contract: `npx hardhat run --network localhost scripts/destinationDeploy.js` 
- Run The `Initialize` Function on Destination contract
- Deploy Source Contract: `npx hardhat run --network localhost scripts/sourceDeploy.js` 
