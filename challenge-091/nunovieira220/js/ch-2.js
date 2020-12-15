// Input
const A = [2, 1, 3, 0, 3, 1, 5, 0, 0, 0, 0, 2];

// Jump Game
if (A.length <= 1) {
  console.log(1);
  exit(0);
}

const targets = {};
targets[A.length - 1] = 1;

for(let i = A.length - 2; i > 0; i--) {
  const jump = i + A[i];

  if (targets[jump]) {
    targets[i] = 1;
  }
}

const res = targets[A[0]] ? 1 : 0;

// Output
console.log(res);