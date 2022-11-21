#! /usr/bin/node

"use strict"

function equaldistribution(list) {
    let s = list.reduce((x, y) => x + y, 0);
    if (s % list.length != 0) {
        return -1;
    }
    let m = s / list.length;
    let out = 0;
    let w = list;
    while (true) {
        for (let i = 0; i < w.length-1; i++) {
            if (w[i] > m) {
                let v = w[i] - m;
                w[i+1] += v;
                out += v;
                w[i] = m;
            } else if (w[i] < m) {
                let v = Math.min(m - w[i], w[i+1]);
                w[i+1] -= v;
                out += v;
                w[i] += v;
            }
        }
        let done = true;
        for (let v of w) {
            if (v != m) {
                done = false;
                break;
            }
        }
        if (done) {
            break;
        }
    }
    return out;
}

if (equaldistribution([1, 0, 5]) == 4) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (equaldistribution([0, 2, 0]) == -1) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (equaldistribution([0, 3, 0]) == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
