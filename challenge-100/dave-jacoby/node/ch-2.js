"use strict";

var input = [];
input.push([[1], [2, 4], [6, 4, 9], [5, 1, 7, 2]]);
input.push([[3], [3, 1], [5, 2, 3], [4, 3, 1, 3]]);

for (let i = 0; i < input.length; i++) {
  triangle_sum(input[i]);
}

function triangle_sum(input) {
  let results = triangle(input, 0, 0, []).sort(function(a, b) { return a - b });
  console.log(input);
  console.log(results[0]);
  console.log("");
}

function triangle(input, x, y, path) {
  if (x > 5) {
    return;
  }
  let output = [];

  if ("undefined" === typeof input[x]) {
    output.push(path.reduce((a, b) => a + b, 0));
  } else {
    let v = input[x][y];
    let next_path = [...path];
    next_path.push(v);

    output.push(...triangle(input, x + 1, y, next_path));
    output.push(...triangle(input, x + 1, y + 1, next_path));
  }
  return output;
}


// [ [ 1 ], [ 2, 4 ], [ 6, 4, 9 ], [ 5, 1, 7, 2 ] ]
// 8
// 
// [ [ 3 ], [ 3, 1 ], [ 5, 2, 3 ], [ 4, 3, 1, 3 ] ]
// 7



