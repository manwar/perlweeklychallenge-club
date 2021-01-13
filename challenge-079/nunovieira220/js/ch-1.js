// Input
const N = 4;

// Count set bits
let counter = 0;

Array.from({ length: N }, (_, i) => i + 1).forEach(n => {
  const bin = parseInt(n, 10).toString(2);
  counter += bin.split('1').length - 1;
});

console.log(counter);