// Check if can have 15
const check15 = (...args) => {
  const zeros = args.filter(n => n === 0).length;
  const sum = args.reduce((a, b) => a + b);

  if(zeros === 1 && sum !== 15) return false;
  if(zeros === 2 && sum <= 5) return false;
  if(zeros === 2 && available[15 - sum] === 0) return false;
  return true;
};

// Test if element is safe
const isSafe = (row, col, val) => {
  // Verify availability
  if(!available[val]) return false;

  // Verify row
  if(!check15(res[row][0], res[row][1], res[row][2], val)) return false;

  // Verify column
  if(!check15(res[0][col], res[1][col], res[2][col], val)) return false;

  // Verify y=x diagonal
  if(row == col && !check15(res[0][0], res[1][1], res[2][2], val)) return false;

  // Verify y=-x diagonal
  if(row + col == 2 && !check15(res[0][2], res[1][1], res[2][0], val)) return false;

  return true;
};

// Solve Magical Matrix
const solve = () => {
  let row = -1;
  let col = -1;

  for (let i = 0; i < 3; i++) {
    index = res[i].indexOf(0);

    if (index > -1) {
      row = i;
      col = index;
      break;
    }
  }

  if (col == -1) return true;

  let result = false;

  for(let i = 1; i < 10; i++) {
    if (isSafe(row, col, i)) {
      available[i] = 0;
      res[row][col] = i;

      result = solve();
      if(result) break;

      available[res[row][col]] = 1;
      res[row][col] = 0;
    }
  }

  return result;
}

// Magical Matrix
const available = Array(10).fill(1);
const res = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];

solve();

// Output
console.log(res);