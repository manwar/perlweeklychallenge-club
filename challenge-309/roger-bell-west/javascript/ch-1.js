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

function mingap(a) {
    let mg = a[a.length - 1] - a[0];
    let mv = 0;
    for (let p of toWindows(a, 2)) {
        const delta = p[1] - p[0];
        if (delta < mg) {
            mg = delta;
            mv = p[1];
        }
    }
    return mv;
}

if (mingap([2, 8, 10, 11, 15]) == 11) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (mingap([1, 5, 6, 7, 14]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (mingap([8, 20, 25, 28]) == 28) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
