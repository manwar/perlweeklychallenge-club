#! /usr/bin/node

"use strict"

function range(from, to) {
    let a = new Array(to - from + 1);
    for (let i = from; i <= to; i++) {
        a.push(i);
    }
    return a;
}

function maxnumber(lst) {
    const po = lst.map (x => x.toString());
    const pl = Math.max(...po.map (x => x.length));
    let pm = [];
    for (let so of po) {
        let sm = so;
        if (so.length < pl) {
            const c = so.slice(-1);
            for (let _i = so.length - pl; _i < 0; _i++) {
                sm += c;
            }
        }
        pm.push(sm);
    }
    let pi = range(0, pm.length - 1);
    pi.sort(function(a, b) {
        if (pm[b] > pm[a]) return 1;
        if (pm[b] < pm[a]) return -1;
        return 0;
    });
    let out = "";
    for (let st of pi) {
        out += po[st];
    }
    return parseInt(out);
}

if (maxnumber([1, 23]) == 231) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxnumber([10, 3, 2]) == 3210) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxnumber([31, 2, 4, 10]) == 431210) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxnumber([5, 11, 4, 1, 2]) == 542111) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxnumber([1, 10]) == 110) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
