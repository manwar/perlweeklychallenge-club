// Input
const N = [2, 1, 4, 3];

// Array of Product
const res = [];

for(let i = 0; i < N.length; i++) {
  const aux = N.filter((_, index) => i !== index);
  res.push(aux.reduce((a, b) => a * b));
}

// Output
console.log(res);