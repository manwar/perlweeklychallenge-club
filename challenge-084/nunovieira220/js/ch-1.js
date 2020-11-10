// Input
const N = -1234;

// Reverse integer
const MAX_INT = Math.pow(2, 31);
const multiplier = N < 0 ? -1 : 1;
let res = 0;

if(N < MAX_INT) {
  res = parseInt(Math.abs(N).toString().split('').reverse().join(''));
}

// Output
console.log(res * multiplier);