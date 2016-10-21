'use strict';

const palindrome = require('is-palindrome');

function isPalindromeDate(date) {
  return palindrome(date);
}

function stringifyDate(date) {
  let month = (date.getMonth() + 1).toString();
  let day = date.getDate().toString();
  let year = (date.getYear() + 1900).toString().substring(2, 4);
  return month + day + year;
}

let startDate = new Date('October 1, 1901');
let nextDateI = 0;

while (true) {
  let totalDays = 0;
  let numPalindromeDays = 0;
  let useDate = new Date(startDate.getTime() + nextDateI * 24 * 60 * 60 * 1000);
  console.log('Starting with: ' + useDate);

  let numDays = 1;
  let i = 0;
  let lastPalindromeDay = startDate;

  while (numPalindromeDays < 101) {
    let newDate = new Date(useDate.getTime() + i * 24 * 60 * 60 * 1000);
    let strDate = stringifyDate(newDate);

    if(isPalindromeDate(strDate) === true) {
      numPalindromeDays++;
      lastPalindromeDay = newDate;
    }
    //console.log(strDate + ': ' + numPalindromeDays);
    i++;
  }
  console.log(lastPalindromeDay);

  let currentDate = useDate;
  totalDays = 1;
  while (currentDate < lastPalindromeDay) {
    currentDate = new Date(useDate.getTime() + totalDays * 24 * 60 * 60 * 1000);
    //console.log(currentDate);
    totalDays++;
  }

  nextDateI++;

  console.log(totalDays);
  console.log(numPalindromeDays);

  if (palindrome(totalDays) && palindrome(numPalindromeDays) && palindrome(stringifyDate(useDate))) {
    console.log('Ending: ' + lastPalindromeDay);
    break;
  }
}
