#! /usr/bin/node

"use strict"

function arraymedian(a, b) {
    let nn = a;
    for (let n of b) {
        nn.push(n);
    }
    nn.sort(function(a, b) {return a-b});
    const i = Math.floor(nn.length / 2);
    if (nn.length % 2 == 0) {
        return (nn[i - 1] + nn[i]) / 2.0;
    } else {
        return nn[i];
    }
}

if (arraymedian([2], [4]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (arraymedian([1, 2, 3], [7, 8, 9, 10]) == 7) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (arraymedian([], [10, 20, 30, 40]) == 25) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (arraymedian([100], [1, 2, 3, 4, 5, 6, 7]) == 4.5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (arraymedian([1, 2, 2], [2, 2, 3]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
