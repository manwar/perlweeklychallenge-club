// Input
let A = 14;
let B = 12;

// Ethiopian Multiplication
let res = 0;

while(A > 1) {
  A = Math.floor(A / 2);
  B = B * 2;
  res += B;
}

// Output
console.log(res);