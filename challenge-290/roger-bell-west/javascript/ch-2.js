#! /usr/bin/node

"use strict"

function luhnalgorithm(a) {
    let digits = [];
    for (let x of a.split("")) {
        if (x >= '0' && x <= '9') {
            digits.push(+x);
        }
    }
    const payload = digits.pop();
    digits.reverse();
    for (let i = 0; i < digits.length; i += 2) {
        digits[i] *= 2;
        if (digits[i] > 9) {
            digits[i] -= 9;
        }
    }
    let s = 0;
    for (let d of digits) {
        s += d;
    }
    return 10 - (s % 10) == payload;
}

if (luhnalgorithm('17893729974')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (luhnalgorithm('4137 8947 1175 5904')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!luhnalgorithm('4137 8974 1175 5904')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
