// Input
const A = [12, 2, 10];

// Flip Array
let sums = [0];

A.forEach(val => {
  const arr = [];

  sums.forEach(sum => arr.push(sum + val, sum - val));

  sums = arr;
});

const res = sums.filter(sum => sum >= 0).sort((a, b) => a - b);

// Output
console.log(res[0]);