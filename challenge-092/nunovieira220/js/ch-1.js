// Input
const A = 'abc';
const B = 'xyz';

// Isomorphic Strings
const mapping = {};
let res = 1;

if (A.length != B.length) return 0;

for (let i = 0; i < A.length; i++) {
  const cA = A.charAt(i);
  const cB = B.charAt(i);

  if(!mapping[cA] && !Object.values(mapping).includes(cB)) mapping[cA] = cB;
  if (mapping[cA] && mapping[cA] === cB) continue;

  res = 0;
  break;
};

// Output
console.log(res);