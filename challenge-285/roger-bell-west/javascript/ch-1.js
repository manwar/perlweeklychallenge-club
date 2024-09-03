#! /usr/bin/node

"use strict"

function noconnection(a) {
    let os = new Set;
    let is = new Set;
    for (let x of a) {
        os.add(x[0]);
        is.add(x[1]);
    }
    const difference = [...is].filter(i => !os.has(i));
    return difference[0];
}

if (noconnection([['B', 'C'], ['D', 'B'], ['C', 'A']]) == 'A') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (noconnection([['A', 'Z']]) == 'Z') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
