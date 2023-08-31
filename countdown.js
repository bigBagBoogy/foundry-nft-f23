// import { encodeImageToBase64 } from "./encodeImageToBase64.js";
import { testinteraction } from "./base64.js";

function calculateCountdown() {
  const now = new Date();
  const endOfMonth = new Date(
    now.getFullYear(),
    now.getMonth() + 1,
    0,
    23,
    59,
    59
  ); // Set to last day of current month
  const timeDifference = endOfMonth - now;

  const days = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
  const hours = Math.floor(
    (timeDifference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
  );
  const minutes = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
  const seconds = Math.floor((timeDifference % (1000 * 60)) / 1000);

  return { days, hours, minutes, seconds };
}

async function updateCountdown() {
  const countdownElement = document.getElementById("countdown");
  const countdown = calculateCountdown();
  const now = new Date();
  const endOfMonth = new Date(
    now.getFullYear(),
    now.getMonth() + 1,
    0,
    23,
    59,
    59
  );

  if (now > endOfMonth) {
    countdownElement.textContent = "NFT's have been sent to the winners";
    console.log("NFT's have been sent to the winners");
    /////////this does not work scince there's no one signing the metamask transaction
    // const imageUrl = "/images/zombiehand.svg";
    // const tokenUri = encodeImageToBase64(imageUrl);
    // await mint(tokenUri);
    // clearInterval(countdownInterval);
  } else {
    countdownElement.innerHTML = `
        <p>Countdown to the next NFT awarding (CEST):</p>
        <p>${countdown.days} days ${countdown.hours} hours ${countdown.minutes} minutes ${countdown.seconds} seconds</p>
      `;
  }
}
testinteraction();

updateCountdown();
const countdownInterval = setInterval(updateCountdown, 1000);
