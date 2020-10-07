// Input
const A = 'abcdabcd';
const B = 'abcdabcdabcdabcd';

// Common Base String
const res = [];
const len = Math.min(A.length, B.length);

for (let i = 0; i < len; i++) {
  const base = A.substring(0, i + 1);
  const regex = new RegExp(`^(${base})+$`);

  if(A.match(regex) && B.match(regex)) res.push(base);
}

// Output
console.log(res);