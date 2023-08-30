import { ethers } from "./ethers-5.6.esm.min.js";
import { abi, contractAddress } from "/constants.js";

export async function mint(tokenUri) {
  if (typeof window.ethereum !== "undefined") {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const contract = new ethers.Contract(contractAddress, abi, provider);

    try {
      const toAddress = "0xEC5DBFed2e8A5E88De2AC7a9E5884B0bD4F6Ca7f";
      console.log(`minting ${tokenUri} to: ${toAddress}`);
      const signer = provider.getSigner();
      const contractWithSigner = contract.connect(signer);
      const tx = await contractWithSigner.mintNFT(toAddress, tokenUri); //metadata
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
    // Base64 encode the entire metadata string
    const encodedMetadata = btoa(metadataString);
    const jsonTokenUri = `data:application/json;base64,${encodedMetadata}`;
    console.log(jsonTokenUri);

    return {
      metadata: metadataString,
      tokenUri: jsonTokenUri,
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
