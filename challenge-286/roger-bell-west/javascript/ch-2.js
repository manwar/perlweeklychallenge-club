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

function ordergame(a) {
    let p = a;
    while (p.length > 1) {
        let q = [];
        let mm = true;
        for (let j of toWindows(p, 2)) {
            if (mm) {
                q.push(Math.min(...j));
            } else {
                q.push(Math.max(...j));
            }
            mm = !mm;
        }
        p = q;
    }
    return p[0];
}

if (ordergame([2, 1, 4, 5, 6, 3, 0, 2]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (ordergame([0, 5, 3, 2]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (ordergame([9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
