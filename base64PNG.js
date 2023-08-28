const fs = require("fs");

// Function to encode a PNG image to base64
function encodeImageToBase64(imagePath) {
  return new Promise((resolve, reject) => {
    fs.readFile(imagePath, (error, data) => {
      if (error) {
        reject(error);
        return;
      }
      const base64Image = data.toString("base64");
      resolve(`data:image/png;base64,${base64Image}`);
    });
  });
}

// Usage
const imagePath = "images/zombieblue.svg"; // Provide the path to your PNG image
encodeImageToBase64(imagePath)
  .then((base64Image) => {
    console.log("Base64 encoded PNG:", base64Image);
  })
  .catch((error) => {
    console.error("Error:", error);
  });
