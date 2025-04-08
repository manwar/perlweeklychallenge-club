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

function circular(a) {
    for (let p of toWindows(a, 2)) {
        if (!p[0].endsWith(p[1].charAt(0))) {
            return false;
        }
    }
    return true;
}

if (circular(['perl', 'loves', 'scala'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!circular(['love', 'the', 'programming'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (circular(['java', 'awk', 'kotlin', 'node.js'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
