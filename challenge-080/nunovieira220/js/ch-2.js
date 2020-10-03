// Input
const A = [1, 4, 3, 2];

// Count candies
let counter = A.length;

A.push(Number.MAX_SAFE_INTEGER);

for (let i = A.length - 1; i >= 0; i--) {
  counter += (A[i] > A[i-1]) + (A[i] > A[i+1]);
}

console.log(counter);