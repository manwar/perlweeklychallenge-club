#! /usr/bin/node

"use strict"
function thirtythreepercentappearance(a) {
    let c = new Map;
    for (let n of a) {
        if (c.has(n)) {
            c.set(n, c.get(n) + 1);
        } else {
            c.set(n, 1);
        }
    }
    let threshold = Math.floor(a.length * 33 / 100);
    if (Math.floor(threshold * 100 / 33) != a.length) {
      threshold += 1
    }
    const s = [...c.keys()].filter(i => c.get(i) >= threshold);
    if (s.length == 0) {
      return -1
    }
    s.sort();
    return s[0];
  }

if (thirtythreepercentappearance([1, 2, 3, 3, 3, 4, 2]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (thirtythreepercentappearance([1, 1]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (thirtythreepercentappearance([1, 2, 3]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
