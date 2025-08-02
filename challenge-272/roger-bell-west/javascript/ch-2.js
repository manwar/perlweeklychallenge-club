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

function stringscore(a) {
    let out = 0;
    for (let t = 0; t < a.length - 1; t++) {
        out += Math.abs(a.charCodeAt(t) - a.charCodeAt(t + 1));
    }
    return out;
}

if (stringscore('hello') == 13) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (stringscore('perl') == 30) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (stringscore('raku') == 37) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
