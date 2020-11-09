// Input
const N = 125;

// Power of Two Integers
let res = 0;

for(let a = 0; a < N; a++) {
  const exp = Math.pow(a, 2);
  if(exp === N) res = 1;
  if(exp >= N) break;

  for(let b = 3; b < N; b++) {
    const exp = Math.pow(a, b);
    if(exp === N) res = 1;
    if(exp >= N) break;
  }
}

// Output
console.log(res);
