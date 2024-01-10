#! /usr/bin/node

"use strict"

function concat(a0, b0) {
    if (b0 == 0) {
        return 10 * a0;
    }
    let a = a0;
    let b = b0;
    while (b > 0) {
        a *= 10;
        b = Math.floor(b / 10);
    }
    return a + b0;
}

function concatenationvalue(a) {
    let t = 0;
    let ms = Math.floor((a.length - 1) / 2);
    for (let i = 0; i <= ms; i++) {
        const j = a.length - 1 - i;
        if (j == i) {
            t += a[i];
        } else {
            t += concat(a[i], a[j]);
        }
    }
    return t;
}

if (concatenationvalue([6, 12, 25, 1]) == 1286) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (concatenationvalue([10, 7, 31, 5, 2, 2]) == 489) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (concatenationvalue([1, 2, 10]) == 112) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
