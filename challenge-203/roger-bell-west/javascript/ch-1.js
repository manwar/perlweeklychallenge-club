#! /usr/bin/node

"use strict"

function specialquads(l) {
    let ct = 0;
    for (let ai = 0; ai < l.length-3; ai++) {
        for (let bi = ai + 1; bi < l.length-2; bi++) {
            for (let ci = bi + 1; ci < l.length-1; ci++) {
                for (let di = ci + 1; di < l.length; di++) {
                    if (l[ai] + l[bi] + l[ci] == l[di]) {
                        ct++;
                    }
                }
            }
        }
    }
    return ct;
}

if (specialquads([1, 2, 3, 6]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (specialquads([1, 1, 1, 3, 5]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (specialquads([3, 3, 6, 4, 5]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
