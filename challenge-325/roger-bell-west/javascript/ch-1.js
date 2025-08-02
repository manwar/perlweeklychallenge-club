#! /usr/bin/node

"use strict"

function consecutiveone(a) {
    let h = new Map;
    h.set(0, 0);
    let latch = 0;
    let latched = false;
    a.forEach((n, i) => {
        if (n == 1 && !latched) {
            latched = true;
            latch = i;
        }
        if (n == 0 && latched) {
            latched = false;
            h.set(latch, i - latch);
        }
    });
    if (latched) {
        h.set(latch, a.length - latch);
    }
    return Math.max(...h.values());
}

if (consecutiveone([0, 1, 1, 0, 1, 1, 1]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (consecutiveone([0, 0, 0, 0]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (consecutiveone([1, 0, 1, 0, 1, 1]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
