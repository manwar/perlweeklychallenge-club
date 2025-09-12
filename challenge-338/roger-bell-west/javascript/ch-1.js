#! /usr/bin/node

"use strict"

function highestrow(a) {
    return Math.max(...a.map(r => r.reduce((x, y) => x + y)));
}

if (highestrow([[4, 4, 4, 4], [10, 0, 0, 0], [2, 2, 2, 9]]) == 16) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (highestrow([[1, 5], [7, 3], [3, 5]]) == 10) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (highestrow([[1, 2, 3], [3, 2, 1]]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (highestrow([[2, 8, 7], [7, 1, 3], [1, 9, 5]]) == 17) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (highestrow([[10, 20, 30], [5, 5, 5], [0, 100, 0], [25, 25, 25]]) == 100) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
