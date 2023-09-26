#! /usr/bin/node

"use strict"

function arrayloops(a) {
    let loop_id = 0;
    let loops = new Map;
    for (let origin = 0; origin < a.length; origin++) {
        if (!loops.has(origin)) {
            let li = 0;
            let thisloop = new Set;
            let x = origin;
            while (true) {
                if (x >= a.length) {
                    break;
                }
                thisloop.add(x);
                x = a[x];
                if (loops.has(x)) {
                    li = loops.get(x);
                    break;
                }
                if (thisloop.has(x)) {
                    loop_id += 1;
                    li = loop_id;
                    break;
                }
            }
            for (let i of thisloop) {
                loops.set(i, li);
            }
        }
    }
    return loop_id;
}

if (arrayloops([4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9, 10]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (arrayloops([0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (arrayloops([9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6, 17]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
