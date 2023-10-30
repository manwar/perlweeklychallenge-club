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

function removeone(a) {
    let ec = 0;
    let le = 1 + a[1] - a[0];
    for (let s of toWindows(a, 2)) {
        if (s[1] <= s[0]) {
            ec++;
            if (ec > 1 || s[0] - s[1] >= le) {
                return false;
            }
        }
        le = s[1] - s[0];
    }
    return true;
}

if (removeone([0, 2, 9, 4, 6])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!removeone([5, 1, 3, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (removeone([2, 2, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
