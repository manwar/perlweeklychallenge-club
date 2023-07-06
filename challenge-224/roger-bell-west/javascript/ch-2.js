#! /usr/bin/node

"use strict"

function exdigits(digits, start, end) {
    let x = 0;
    for (let i = start; i <= end; i++) {
        x *= 10;
        x += digits[i];
    }
    return x;
}

function additivenumber(digitstring) {
    const digits = [...digitstring].map(Number);
    let stack = [];
    for (let i = 0; i <= digits.length - 3; i++) {
        for (let j = i + 1; j <= digits.length - 2; j++) {
            stack.push([0, i, j]);
        }
    }
    while (stack.length > 0) {
        const x = stack.pop();
        const start_a = x[0];
        const end_a = x[1];
        const start_b = end_a + 1;
        const end_b = x[2];
        const val_ab = exdigits(digits, start_a, end_a) +
              exdigits(digits, start_b, end_b);
        const start_c = end_b + 1;
        for (let end_c = start_c; end_c <= digits.length - 1; end_c++) {
            if (val_ab == exdigits(digits, start_c, end_c)) {
                if (end_c == digits.length - 1) {
                    return true;
                } else {
                    stack.push([start_b, end_b, end_c]);
                    break;
                }
            }
        }
    }
    return false;
}

if (additivenumber('112358')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!additivenumber('12345')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (additivenumber('199100199')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
