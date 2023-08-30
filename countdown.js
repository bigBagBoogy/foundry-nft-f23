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

function updateCountdown() {
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
    clearInterval(countdownInterval);
  } else {
    countdownElement.innerHTML = `
        <p>Countdown to the next NFT awarding (CEST):</p>
        <p>${countdown.days} days ${countdown.hours} hours ${countdown.minutes} minutes ${countdown.seconds} seconds</p>
      `;
  }
}

updateCountdown();
const countdownInterval = setInterval(updateCountdown, 1000);
