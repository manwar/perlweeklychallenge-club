#! /usr/bin/node

"use strict"

function pythagorasmultiplied(n) {
    let ct = 0;
    for (let c = 5; c <= n; c++) {
        const csquared = c * c;
        for (let a = 1; a <= c - 2; a++) {
            const asquared = a * a;
            for (let b = a + 1; b <= c - 1; b++) {
                const bsquared = b * b;
                const tot = asquared + bsquared;
                if (tot > csquared) {
                    break;
                }
                if (tot == csquared) {
                    ct += 1;
                }
            }
        }
    }
    return ct * 2;
}

if (pythagorasmultiplied(20) == 12) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (pythagorasmultiplied(7) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (pythagorasmultiplied(1) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (pythagorasmultiplied(15) == 8) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (pythagorasmultiplied(30) == 22) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
