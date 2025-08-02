#! /usr/bin/node

"use strict"

function stepbystep(a) {
    let mv = 0;
    let tot = 0;
    for (let s of a) {
        tot += s;
        if (mv > tot) {
            mv = tot;
        }
    }
    return 1 - mv;
}

if (stepbystep([-3, 2, -3, 4, 2]) == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (stepbystep([1, 2]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (stepbystep([1, -2, -3]) == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
