// Input
const A = [3, 1, 3, 1, 1, 5];

// Trapped rain water counter
let counter = 0;
let max = 0;

A.forEach(item => {
  if(item >= max) {
    max = item;
  } else {
    counter += max - item;
  }
});

// Output
console.log(counter);