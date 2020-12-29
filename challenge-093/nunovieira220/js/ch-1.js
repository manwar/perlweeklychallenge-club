// Input
const coords = [[1, 1], [2, 2], [3, 1], [1, 3], [5, 3]];

// Max Points
const points = {};
let res = 1;

// Test if defined
const isDefined = (a, b, p) => points[a] && points[a][b] && points[a][b][p] && points[a][b][p] > 0;

// Update value
const update = (a, b, a1, b1, p) => {
  const val = isDefined(a1, b1, p) ? points[a1][b1][p] + 1 : 1;
  points[a][b][p] = val;
  if(val > res) res = val;
};

// Add new point
const addPoint = (fst, snd) => {
  if(!points[fst]) points[fst] = {};
  points[fst][snd] = {};

  update(fst, snd, fst + 1, snd, 'r');
  update(fst, snd, fst, snd + 1, 'u');
  update(fst, snd, fst + 1, snd + 1, 'ru');
  update(fst, snd, fst + 1, snd - 1, 'rd');
};

// Update line points
const updateLinePoints = (fst, snd) => {
  for(let i = 1; isDefined(fst - i, snd, 'r'); i++) {
    update(fst - i, snd, fst - i + 1, snd, 'r');
  }

  for(let i = 1; isDefined(fst, snd - i, 'u'); i++) {
    update(fst, snd - i, fst, snd - i + 1, 'u');
  }

  for(let i = 1; isDefined(fst - i, snd - i, 'ru'); i++) {
    update(fst - i, snd - i, fst - i + 1, snd - i + 1, 'ru');
  }

  for(let i = 1; isDefined(fst - i, snd + i, 'rd'); i++) {
    update(fst - i, snd + i, fst - i + 1, snd + i - 1, 'rd');
  }
};

coords.forEach(([fst, snd]) => {
  if(!points[fst] || !points[fst][snd]) {
    addPoint(fst, snd);
    updateLinePoints(fst, snd);
  }
});

// Output
console.log(res);