// Input
const N = 4;

// GCD
const gcd = (a, b) => {
  return b == 0 ? a : gcd(b, a % b);
}

// GCD Sum
let res = 0;

for(let i = 1; i <= N; i++) {
  for(let j = i + 1; j <= N; j++) {
    res += gcd(i, j);
  }
}

// Output
console.log(res);