#! /usr/bin/node

"use strict"

function nestedarray(a) {
    let arr = 0;
    for (let i = 0; i < a.length; i++) {
        let trail = new Set;
        let j = i;
        while (true) {
            j = a[j];
            if (trail.has(j)) {
                break;
            }
            trail.add(j);
        }
        arr = Math.max(arr, trail.size);
    }
    return arr
}

if (nestedarray([5, 4, 0, 3, 1, 6, 2]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (nestedarray([0, 1, 2]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
