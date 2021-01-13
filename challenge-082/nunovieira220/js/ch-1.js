// Input
const M = 12;
const N = 18;

// Common Base String
const res = [];

for (let i = 1; i < Math.min(M, N); i++) {
  if(M % i === 0 && N % i == 0) res.push(i);
}

// Output
console.log(res);