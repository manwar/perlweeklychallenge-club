// Input
const matrix = [
  [1, 1, 0, 1],
  [1, 1, 0, 0],
  [0, 1, 1, 1],
  [1, 0, 1, 1]
];

// Find square
const M = matrix.length;
const N = matrix[0].length;
let count = 0;

for(let i = 0; i < M - 1; i++) {
  for(let j = 0; j < N - 1; j++) {
    const min = Math.min(M - i, N - j);

    for(let k = 1; k < min; k++) {
      if (matrix[i][j] == 1 && matrix[i + k][j] == 1 &&
        matrix[i][j + k] == 1 && matrix[i + k][j + k] == 1) count++;
    }
  }
}

// Output
console.log(count);