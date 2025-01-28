#! /usr/bin/node

"use strict"

// by VLAZ
// https://stackoverflow.com/a/59322890
function toWindows(inputArray, size) {
  return Array.from(
    {length: inputArray.length - (size - 1)}, //get the appropriate length
    (_, index) => inputArray.slice(index, index+size) //create the windows
  )
}

function oddsum(a) {
    let out = a.reduce((x, y) => x + y);
    let l = 3;
    while (l <= a.length) {
        for (let s of toWindows(a, l)) {
            out += s.reduce((x, y) => x + y);
        }
        l += 2;
    }
    return out;
}

if (oddsum([2, 5, 3, 6, 4]) == 77) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (oddsum([1, 3]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
