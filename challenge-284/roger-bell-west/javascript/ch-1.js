#! /usr/bin/node

"use strict"

function luckyinteger(a) {
    let c = new Map();
    for (let p of a) {
        if (c.has(p)) {
            c.set(p,c.get(p)+1);
        } else {
            c.set(p,1);
        }
    }
    let c1 = [...c.values()];
    c1.sort(function(aa, bb) {
        return bb - aa;
    });
    let c2 = [...c.keys()];
    c2.sort(function(aa, bb) {
        return bb - aa;
    });
    for (let v1 of c1) {
        for (let v2 of c2) {
            if (c.get(v2) == v1 && v1 == v2) {
                return v2;
            }
        }
    }
    return -1
}

if (luckyinteger([2, 2, 3, 4]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (luckyinteger([1, 2, 2, 3, 3, 3]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (luckyinteger([1, 1, 1, 3]) == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
