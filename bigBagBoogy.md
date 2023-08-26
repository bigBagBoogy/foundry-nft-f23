# instant push copy paste all below in one go:

git init
git branch -M main
git add .
git commit -m "amended code"
git push -u origin main

# todo:⭐️

Top5 now returns the addresses and scores, but the scores are of type bigNumber, so need to be converted.
Right now 1 player can be in the top5 twice somehow. So it seems that eventhough his savedProgress is overwritten, The topscore addition is a unique instance.

# let's:

Offer 2 tiers of cheating: CheatSilver and CheatGold. Let's make these $5 and $10
These fiat amounts need to be measured against the current price of ETH/USD?
We'll write the code for this, but comment it out, since keeping track of chainlink pricefeed
funding might not be wanted.
html: button -> popup with CheatSilver and CheatGold buttons. onclick=CheatSilver()
For now we'll work off a price for ETH of $2000,
so CheatSilver = 0.0025 ETH and CheatGold = 0.005 ETH (2500000000000000 WEI and 5000000000000000)

# if needed install npm install --save-dev dotenv-webpack

totalScore (skullies) must me capped at 1e50!!!! in JS/score.js
to cap this, let's add a function that triggers at 1e50 skullies and sets all elements
to lvl10, which in term will trigger the function: levelUpStage()
podiumLvl = 1;
drinksLvl = 1;
etc, etc,
stageStartOverLvl++;

To otherwise call levelUpStage() though, we'll have to add a "checker" that looks for:
All elementsLvl = 10 to be true

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

# bigBagBoogie interim note:

# bigBagBoogie:

//uint8 = 3 uint16 = 5 uint32 = 10 uint64 = 20 uint128 = 39 uint256 = 77

# Layout of Contract:

// version
// imports
// interfaces, libraries, contracts
// errors
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

# bugs along the way to learn from:

1. connectWeb3.js needs to be typecasted: type="module" in it's html element and
score.js MUST not! otherwise all functions will break `undefinded`.
You can not and don't need to (if you use VAR for variables you need in both files),
do: "// import "./score.js";" in connectWeb3.js. If you do, It will call the inteval function double, with wrong arguments.

2. If You see this error in the browser console: `ethers-5.6.esm.min.js:16475     POST https://eth-sepolia.g.alchemy.com/v2/69txysSR3src6m4REhIftFAI2BYyEgcN net::ERR_NAME_NOT_RESOLVED`
It means you're not connected to the internet!

3. When running Anvil, you can only test 1 deployed contract at a time.
When you run an other deploy script, the first one gets overwritten.

forge script script/DeployGameProgressAndTopFive.s.sol
forge script script/DeployCheatpay.s.sol  <---- this one is now "live"
````

4. browser console: BlockOutOfRangeError: `inpage.js:1 MetaMask - RPC Error: [ethjs-query] while formatting outputs from RPC '{"value":{"code":-32603,"data":{"code":-32602,"message":"BlockOutOfRangeError: block height is 657 but requested was 1946"}}}'`

# solution:

If you quit this and on a later occasion you want to do this again you will need to first open your metamask,
go to settings, --- advanced, --- and choose RESET WALLET
otherwise you will get this BlockOutOfRangeError error in the console and the functions wont work anymore.

5. Error saving progress: ReferenceError: Cannot access 'provider' before initialization
   at HTMLButtonElement.saveProgress (connectWeb3.js:202:20)
   --> when calling saveProgress

   solution: This was a scope issue. I had these lines outside the saveProgress() :

   ````const provider = new ethers.providers.JsonRpcProvider(
   "https://eth-sepolia.g.alchemy.com/v2/69txysSR3src6m4REhIftFAI2BYyEgcN"
   );
   const contractCheat = new ethers.Contract(
   contractAddressGameProgressAndTopFive,
   abiGameProgressAndTopFive,
   provider
   );```

   ````

   # note:

   I'm having a hunch that the "provider" I'm using can be 1 of (at least) 2:

   1. window.ethereum (metamask) can be a provider. I'm using that for the fundMe stuff.
   2. JsonRpcProvider from Alchemy, for use with sepolia eth. I use for gameProgress.

   - I may need to deploy to sepolia to test these functions.
     ChatGPT says I need to use: `const provider = new ethers.providers.JsonRpcProvider("http://localhost:8545");` for testing within Anvil
     --> indeed I got `Progress saved successfully` when using http://localhost:8545!

6. connectWeb3.js:211 Error saving progress: Error: unknown account #0 (operation="getAddress", code=UNSUPPORTED_OPERATION, version=providers/5.1.2)
   at Logger.makeError (ethers-5.6.esm.min.js:2919:19)
   at Logger.throwError (ethers-5.6.esm.min.js:2928:16)
   at ethers-5.6.esm.min.js:19070:18
   at async Promise.all (:5500/index 0)

   # chatGpt: Yes, the error message you're encountering seems to indicate that the operation "getAddress" is trying to retrieve the address of the msg.sender. In Ethereum smart contracts, msg.sender refers to the address of the sender of the current transaction.

In your JavaScript code, you are using provider.getSigner() to get the signer object. The error message suggests that the operation "getAddress" is not supported or available in the current context. This operation is likely being used to fetch the address of the Ethereum account associated with the signer.

# to do before testing with Sepolia:

7. inpage.js:1 MetaMask - RPC Error: Internal JSON-RPC error.

I suspect this error indicates a revert from the contract logic

8. Withdraw works, only it withdraws 0.00 everytime instead of the contract(balance).

I've checked:

- Metamask account named: Anvil has the "90d" default private key. so I_owner == msg.sender.

what is weird: In stead of reverting when trying to withdraw with a different account
(from a different address than owner) The transaction does not revert, but withdraws 0.00 also.

The logs (when testing in remix) show 0 because this transaction happens in 2 legs:
"The reason you are seeing "value: 0 WEI" in the logs is not due to that line of code. It is actually because the transaction receipt's value field represents the amount of Ether sent with the transaction, not the amount transferred in the call function.

Since you are using the call function to transfer the balance, which does not involve sending Ether with the transaction, the value field in the transaction receipt will always show 0 WEI."

When we withdraw we'll be sending to the owner, which seems to be the contract itself and not the deployer of the contract. That's why the balance of the contract does not go down,
and the balance of the "Anvil default account" doesn't go up.

9. When in REMIX a transaction will fail with: `Gas estimation failed
Gas estimation errored with the following message (see below). The transaction execution will likely fail. Do you want to force sending?
Returned error: {"jsonrpc":"2.0","error":"Failed to fetch","id":5555853624322585}`
   also when there is no internet connection.

# deploying to sepolia:

1.  source .env

2.  forge script script/DeployGameProgressAndTopFive.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY -vvvv
