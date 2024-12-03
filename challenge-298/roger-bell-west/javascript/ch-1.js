#! /usr/bin/node

"use strict"

function maximalsquare(a) {
    let mx = 0;
    const boundy = a.length;
    const boundx = a[0].length;
    for (let y = 0; y < boundy; y++) {
        for (let x = 0; x < boundx; x++) {
            let size = 0;
            while (true) {
                let tests = [];
                for (let xx = x; xx <= x + size; xx++) {
                    tests.push([y + size, xx]);
                }
                if (size > 0) {
                    for (let yy = y; yy < y + size; yy++) {
                        tests.push([yy, x + size]);
                    }
                }
                if (Math.min(...tests.map(i => a[i[0]][i[1]])) == 0) {
                    break;
                }
                size += 1;
                if (x + size >= boundx || y + size >= boundy) {
                    break;
                }
            }
            mx = Math.max(mx, size * size);
        }
    }
    return mx;
}

if (maximalsquare([[1, 0, 1, 0, 0], [1, 0, 1, 1, 1], [1, 1, 1, 1, 1], [1, 0, 0, 1, 0]]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximalsquare([[0, 1], [1, 0]]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximalsquare([[0]]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
