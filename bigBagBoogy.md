# instant push copy paste all below in one go:

git init
git branch -M main
git add .
git commit -m "amended code"
git push -u origin main

# todo:⭐️

1. create a fresh new top5Nft.sol contract (within this directory).
2. automate svg to base64
3. Create a receiver for the players topscore and place in the top5
4. automate generating the URI
   (so base64 imgURI + metadata: { topPlayer: 1 } { topScore: 500044515 } )
5. Have 1 main function that upon calling with the parameters:
   main(500044515, 400068721, 200001582) which will reflect:
   topPlayer1topScore = 500044515
6. At the end of the month the contract should automatically call the function

# let's:

look into creating ECMAScript modules. 🧩

# end of todo..........................................

The keyboard shortcut to toggle word wrap is Alt+Z
The keyboard shortcut to zoom is Ctrl+ + and/or Ctrl+ - (on the num-pad)

forge test --mt <nameOfTest> -vvv
forge script script/DeployGameProgressAndTopFive.s.sol
forge script script/DeployCheatpay.s.sol

# Importin Anvil localhost into Metamask with 10000 eth:

open metamask
click import account
in cli: `make anvil`
take a private key and paste it into metamask to import account
click ADD NETWORK
copy - paste account from cli (anvil)
symbol: eth
rpc-url: http://127.0.0.1:8545
chainid: 31337

This will deploy all contracts to the "fake" Anvil localhost blockchain (chainId 31337)
Update your constants.js and constantsCheatpay.js with the new contract address.
You'll see it near the top of the hardhat output.

Connect your metamask to your local hardhat blockchain.
`PLEASE USE A METAMASK ACCOUNT THAT ISNT ASSOCIATED WITH ANY REAL MONEY.`

Additionally, add your localhost with chainid 31337 to your metamask.

2. open the frontend and
   Click the “Go Live” button at the bottom-right-hand corner of VSCode to start a server on port 5500. This will also often prompt your browser to open a new window/tab that loads your index.html file.
   If the browser doen't open then go to [a link]http://127.0.0.1:5500/
   !!! You might not be connected to your website (local frontend) with the right account
   --check this in the browser console. You need to be connected to the Anvil account with
   funds in it.

3. You can play around with the website functionality including funding, and withdrawing. The balance is logged into the console, so to see that, press cmd/ctrl + shift + i
   and then press the balance button.

If you quit this and the on a later occasion you want to do this again you will need to first open your metamask,
go to settings, --- advanced, --- and choose RESET WALLET
otherwise you will get this NONCE error in the console and the functions wont work anymore.

````MetaMask - RPC Error:
[ethjs-query] while formatting ouputs from RPC '{"value":{"code":-32603,"data":{"code":-32000,"message":"Nonce too high. Expected nonce to be 2 but got 4. Note that transactions can't be queued when automining."}}}'```

have fun!

````

# other:

The DeployMoodNft.sol script has the a-z for reading in an img file, converting it to base64,
concatenating it, base64 that and then concatenating it woth the metaData to the tokenUri.

1. line 39 read in svg files
2. line 45 upon deploy call: svgToImageURI
3. In MoodNft.sol the ImageURI is concatenated with the metaData

4. source .env

5. forge script script/DeployMoodNft.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY -vvvv

0xd3e20C1942828d60310F6ddC4547ff736819Aff9 sepolia gold
0x7a0902f2BB39AC88b275c9Aa044E0E486FA014CF sepolia silver
0x017B5b379415036808C20989fAbBE40834c98a46 sepolia bronze

after deploying MoodNft go to interactions and replace contract in function run()

6. forge script script/Interactions.s.sol:MintMoodNft --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY -vvvv
