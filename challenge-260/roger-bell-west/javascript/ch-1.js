#! /usr/bin/node

"use strict"

function uniqueoccurrences(a) {
    let c = new Map;
    for (let n of a) {
        if (c.has(n)) {
            c.set(n, c.get(n) + 1);
        } else {
            c.set(n, 1);
        }
    }
    if (c.size == new Set(c.values()).size) {
        return 1;
    } else {
        return 0;
    }
}

if (uniqueoccurrences([1, 2, 2, 1, 1, 3]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (uniqueoccurrences([1, 2, 3]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (uniqueoccurrences([-2, 0, 1, -2, 1, 1, 0, 1, -2, 9]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
