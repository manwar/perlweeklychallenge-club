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

function goodinteger(a) {
    const winsize = 3;
    const d = a.toString().split("");
    let ex = -1;
    toWindows(d, winsize).forEach((cc, offset) => {
        if (ex == -1 && cc[0] == cc[1] && cc[1] == cc[2]) {
            if ((offset == 0 || d[offset- 1] != cc[0]) &&
                (offset == d.size - winsize || d[offset + winsize] != cc[2])) {
                ex = +cc.join("");
            }
        }
    });
    return ex;
}

if (goodinteger(12344456) == 444) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goodinteger(1233334) == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goodinteger(10020003) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
