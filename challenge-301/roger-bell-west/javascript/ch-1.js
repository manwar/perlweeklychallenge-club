#! /usr/bin/node

"use strict"

function largestnumber(a) {
    let ax = a.map(x => x.toString());
    ax.sort(function(i, j) {
        const ij = Number(i + j);
        const ji = Number(j + i);
        return ji - ij;
    });
    return Number(ax.join(""));
}

if (largestnumber([20, 3]) == 320) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (largestnumber([3, 30, 34, 5, 9]) == 9534330) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
