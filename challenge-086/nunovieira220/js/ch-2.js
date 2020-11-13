// Get square index
const squareIndex = val => val < 3 ? 2 : (val < 6 ? 5 : 8);

// Create and fill safe list
const createSafes = board => {
  const safes = [];

  for(let i = 0; i < 9; i++) {
    if(!safes[i]) safes[i] = [];
    safes[i][9] = [];

    for(let j = 0; j < 9; j++) {
      if(!safes[9]) safes[9] = [];
      if(i === 0) safes[9][j] = [];

      const val = board[i][j];
      const iSquare = squareIndex(i);
      const jSquare = squareIndex(j);

      if(!safes[iSquare]) safes[iSquare] = [];
      if(!safes[iSquare][jSquare]) safes[iSquare][jSquare] = [];

      if(val != 0) {
        safes[i][9].push(val);
        safes[9][j].push(val);
        safes[iSquare][jSquare].push(val);
      }
    }
  }

  return safes;
};

// Test if element is safe
const isSafe = (safes, row, col, val) => {
  const onRow = safes[row][9].includes(val);
  const onCol = safes[9][col].includes(val);
  const onSquare = safes[squareIndex(row)][squareIndex(col)].includes(val);

  return !onRow && !onCol && !onSquare;
};

// Add safe element
const addSafeValue = (board, safes, row, col, val) => {
  board[row][col] = val;

  safes[row][9].push(val);
  safes[9][col].push(val);
  safes[squareIndex(row)][squareIndex(col)].push(val);
};

// Remove safe alement
const removeSafeValue = (board, safes, row, col, val) => {
  const iSquare = squareIndex(row);
  const jSquare = squareIndex(col);

  board[row][col] = 0;

  safes[row][9] = safes[row][9].filter(i => i !== val);
  safes[9][col] = safes[9][col].filter(i => i !== val);
  safes[iSquare][jSquare] = safes[iSquare][jSquare].filter(i => i !== val);
};

// Solve sudoku game
const solve = (board) => {
  const safes = createSafes(N);
  let row = -1;
  let col = -1;

  for (let i = 0; i < 9; i++) {
    const index = board[i].indexOf(0);

    if (index > -1) {
      row = i;
      col = index;
      break;
    }
  }

  if (col === -1) return true;

  let result = false;
  for (let val = 1; val <= 9; val++) {
    if (isSafe(safes, row, col, val)) {
      addSafeValue(board, safes, row, col, val);

      result = solve(board, safes);
      if (result) break;

      removeSafeValue(board, safes, row, col, val);
    }
  }

  return result;
}

// Input
const N = [
  [0, 9, 0, 6, 0, 0, 8, 0, 0],
  [0, 0, 0, 5, 0, 3, 4, 0, 0],
  [8, 0, 7, 0, 0, 0, 6, 1, 0],
  [0, 0, 0, 0, 5, 0, 0, 0, 7],
  [0, 0, 0, 7, 9, 0, 1, 0, 0],
  [0, 0, 0, 0, 0, 6, 3, 0, 0],
  [0, 7, 0, 0, 0, 0, 0, 2, 0],
  [0, 4, 0, 0, 0, 0, 0, 0, 0],
  [2, 0, 3, 0, 6, 1, 0, 0, 4]
];

// Solve Sudoku
solve(N);

// Output
console.log(require('util').inspect(N, { depth: null }));