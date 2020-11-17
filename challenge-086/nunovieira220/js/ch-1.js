// Input
const N = [10, 30, 20, 50, 40];
const A = 15;

// Pair Difference
let res = 0;

for(let i = 0; i < N.length - 1; i++) {
  for(let j = i; j < N.length; j++) {
    if(N[i] - N[j] === A || N[j] - N[i] === A) {
      res = 1;
      break;
    }
  }

  if(res === 1) break;
}

// Output
console.log(res);