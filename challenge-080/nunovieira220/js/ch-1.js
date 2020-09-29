// Input
const A = [5, 2, -2, 0];

// Smallest positive number bits
const flags = [1];

A.forEach(n => {
  if(n >= 0) flags[n] = 1;
});

console.log(flags.findIndex(Object.is.bind(null, undefined)));