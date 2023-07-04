#! /usr/bin/node

"use strict"

function boxcoins(ints) {
    let mx = 0;
    let stack = [ [ ints, 0 ] ];
    while (stack.length > 0) {
        const x = stack.pop();
        const t = x[0];
        const tot = x[1];
        if (tot > mx) {
            mx = tot;
        }
        for (let i = 0; i < t.length; i++) {
            let p = t[i];
            if (i > 0) {
                p *= t[i - 1];
            }
            if (i < t.length - 1) {
                p *= t[i + 1];
            }
            const stot = tot + p;
            let tt = [];
            for (let ix = 0; ix < t.length; ix++) {
                if (i != ix) {
                    tt.push(t[ix]);
                }
            }
            stack.push([tt, stot]);
        }
    }
    return mx;
}

if (boxcoins([3, 1, 5, 8]) == 167) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (boxcoins([1, 5]) == 10) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
