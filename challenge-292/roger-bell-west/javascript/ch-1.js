#! /usr/bin/node

"use strict"

function twicelargest(a) {
    let p = [...a];
    p.sort(function(aa, bb) {
        return bb - aa;
    });
    let ret = -1;
    if (p[0] >= 2 * p[1]) {
        a.forEach((c, i) => {
            if (c == p[0] && ret == -1) {
                ret = i;
            }
        });
    }
    return ret;
}

if (twicelargest([2, 4, 1, 0]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (twicelargest([1, 2, 3, 4]) == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
