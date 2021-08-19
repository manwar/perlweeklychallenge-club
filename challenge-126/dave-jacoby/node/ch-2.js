"use strict";

let minemap = [];
let field = function () {
  /*
x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x
*/
}
  .toString()
  .split(/\/\*/)[1]
  .split(/\*\//)[0]
  .split(/\n/)
  .filter((x) => String(x).match(/\w/));

let maxx = 0;
let maxy = 0;

for (let x in field) {
  maxx = x;
  let rowstr = field[x];
  let row = rowstr.split(/\s+/g);
  minemap[x] = new Array(row.length);
  for (let y in row) {
    maxy = y;
    minemap[x][y] = "0";
    if (row[y] === "x") {
      minemap[x][y] = "x";
    }
  }
}
for (let x = 0; x <= maxx; x++) {
  for (let y = 0; y <= maxy; y++) {
    if (minemap[x][y] === "x") {
      for (let i = -1; i <= 1; i++) {
        for (let j = -1; j <= 1; j++) {
          if (!(i == 0 && i == j)) {
            let xx = x + i;
            let yy = y + j;
            if (xx >= 0 && yy >= 0 && xx <= maxx && yy <= maxy) {
              if (minemap[xx][yy] != "x") {
                minemap[xx][yy]++;
              }
            }
          }
        }
      }
    }
  }
}
for (let x = 0; x <= maxx; x++) {
  console.log(minemap[x].join(" "));
}

// console.log([maxx, maxy, minemap]);
