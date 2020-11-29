// Handle spiral matrix
const handleMatrix = (matrix) => {
  let res = [];

  if(!matrix.length) return res;

  const firstRow = matrix.splice(0, 1)[0];
  res = res.concat(firstRow);

  if(matrix.length > 0) {
    for(let i = 0; i < matrix.length - 1; i++) {
      const lastElem = matrix[i].splice(matrix[i].length - 1, 1)[0];
      res.push(lastElem);
    }

    const lastRow = matrix.splice(matrix.length - 1, 1)[0];
    res = res.concat(lastRow.reverse());

    for(let i = matrix.length - 1; i >= 0; i--) {
      const firstElem = matrix[i].splice(0, 1)[0];
      res.push(firstElem);
    }
  }

  return res.concat(handleMatrix(matrix));
}

// Input
const N = [
  [ 1,  2,  3,  4],
  [ 5,  6,  7,  8],
  [ 9, 10, 11, 12],
  [13, 14, 15, 16]
];

// Spiral Matrix
const res = handleMatrix(N);

// Output
console.log(res);