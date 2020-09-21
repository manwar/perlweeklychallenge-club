// Input
const A = [7, 4, 2, 6, 3];
const B = [1, 3, 4];

// Execute left rotation
const arr = [];
let index = 0;

B.forEach(i => {
  const jump = i - index;

  for(let j = 0; j < jump; j++) {
    const val = A.shift();
    A.push(val);
  }

  index += jump;

  // Output
  console.log(A.join(', '));
});