import { ethers } from "./ethers-5.6.esm.min.js";
import { abi, contractAddress } from "/constants.js";
// import fs from "fs/promises"; // Use promises version of fs for async operations

export async function mint() {
  if (typeof window.ethereum !== "undefined") {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const contract = new ethers.Contract(contractAddress, abi, provider);

    try {
      const testUri =
        '{"name":"Mood NFT", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", "attributes": [{"trait_type": "moodiness", "value": 100}], "image":"data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgIGhlaWdodD0iNDAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgZmlsbD0ieWVsbG93IiByPSI3OCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIzIi8+CiAgPGcgY2xhc3M9ImV5ZXMiPgogICAgPGNpcmNsZSBjeD0iNjEiIGN5PSI4MiIgcj0iMTIiLz4KICAgIDxjaXJjbGUgY3g9IjEyNyIgY3k9IjgyIiByPSIxMiIvPgogIDwvZz4KICA8cGF0aCBkPSJtMTM2LjgxIDExNi41M2MuNjkgMjYuMTctNjQuMTEgNDItODEuNTItLjczIiBzdHlsZT0iZmlsbDpub25lOyBzdHJva2U6IGJsYWNrOyBzdHJva2Utd2lkdGg6IDM7Ii8+Cjwvc3ZnPg=="}';
      const toAddress = "0xEC5DBFed2e8A5E88De2AC7a9E5884B0bD4F6Ca7f";
      // console.log(`minting ${metadata} to: ${toAddress}`);

      const signer = provider.getSigner();
      const contractWithSigner = contract.connect(signer);
      const tx = await contractWithSigner.mintNFT(toAddress, testUri); //metadata
      await tx.wait();
      console.log("NFT minted successfully");
    } catch (error) {
      console.error("Error minting NFT:", error);
    }
  } else {
    console.error("Web3 provider not found (e.g., MetaMask)");
  }
}
export async function encodeImageToBase64(imageUrl) {
  try {
    const response = await fetch(imageUrl);
    const data = await response.blob();

    const base64Image = await new Promise((resolve) => {
      const reader = new FileReader();
      reader.onloadend = () => {
        resolve(reader.result);
      };
      reader.readAsDataURL(data);
    });

    const metaData =
      '{"name":"winner", "description":"An NFT for the monthly top-score, 100% on Chain!", ';
    const metaData2 =
      '"attributes": {"trait_type": "Monthly Winner", "value": "200"}, "image":"';
    const imgUri = `data:image/svg+xml;base64,${base64Image.split(",")[1]}`;
    const closingTag = '"}';

    const metadataString = `${metaData}${metaData2}${imgUri}${closingTag}`;
    return {
      metadata: metadataString,
      imgUri: imgUri,
    };
  } catch (error) {
    throw error;
  }
}

// async function encodeImageToBase64(imagePath) {
//   try {
//     const data = await fs.readFile(imagePath);
//     const base64Image = data.toString("base64");

//     const metaData =
//       '{"name":"winner", "description":"An NFT for the monthly top-score, 100% on Chain!", ';
//     const metaData2 =
//       '"attributes": [{"trait_type": "Monthly Winner", "value": "200"}], "image":"';
//     const closingTag = '"}';
//     const imgUri = `data:image/svg+xml;base64,${base64Image}`;

//     return `${metaData}${metaData2}${imgUri}${closingTag}`;
//   } catch (error) {
//     throw error;
//   }
// }
