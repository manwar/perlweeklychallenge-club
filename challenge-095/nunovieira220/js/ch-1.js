// Input
const num = 1221;

// Palindrome Number
const numStr = `${num}`;
const res = numStr === numStr.split('').reverse().join('') ? 1 : 0;

// Output
console.log(res);