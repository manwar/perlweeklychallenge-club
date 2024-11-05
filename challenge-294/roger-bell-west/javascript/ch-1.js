#! /usr/bin/node

"use strict"

function consecutivesequence(a){
    let b = [...a];
    b.sort(function(aa, bb) {
        return aa - bb;
    });
    let mxlen = 0;
    let here = 0;
    while (true) {
        for (let there = here + 1; there <= b.length - 1; there++) {
            if (b[there] != there - here + b[here]) {
                const l = there - here;
                if (l > mxlen) {
                    mxlen = l;
                }
                here = there;
                break;
            }
            if (there == b.length - 1) {
                const l = there - here + 1;
                if (l > mxlen) {
                    mxlen = l;
                }
                here = there;
                break;
            }
        }
        if (here >= b.length - 1) {
            break;
        }
    }
    if (mxlen < 2) {
        mxlen = -1;
    }
    return mxlen;
}

if (consecutivesequence([10, 4, 20, 1, 3, 2]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (consecutivesequence([0, 6, 1, 8, 5, 2, 4, 3, 0, 7]) == 9) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (consecutivesequence([10, 30, 20]) == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
