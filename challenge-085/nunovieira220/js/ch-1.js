// Input
const R = [0.2, 1.5, 0.9, 1.1];

// Triplet Sum
let res = 0;

for(let i = 0; i < R.length - 2; i++) {
  const sum = R[i] + R[i + 1] + R[i + 2];

  if(sum > 1 && sum < 2) {
    res = 1;
    break;
  }
}

// Output
console.log(res);