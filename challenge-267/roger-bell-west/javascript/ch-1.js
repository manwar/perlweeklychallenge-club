#! /usr/bin/node

"use strict"

function productsign(a) {
    let out = 1;
    for (let t of a) {
        if (t < 0) {
            out = -out;
        } else if (t == 0) {
            out = 0;
        }
    }
    return out;
}

if (productsign([-1, -2, -3, -4, 3, 2, 1]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (productsign([1, 2, 0, -2, -1]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (productsign([-1, -1, 1, -1, 2]) == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
