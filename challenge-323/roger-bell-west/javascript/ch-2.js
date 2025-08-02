#! /usr/bin/node

"use strict"

function taxamount(income, brackets) {
    let tax = 0
    let lastbracket = 0
    for (let bracket of brackets) {
        if (income > lastbracket) {
            tax += (Math.min(income, bracket[0]) - lastbracket) * bracket[1];
        } else {
            break;
        }
        lastbracket = bracket[0];
    }
    return tax / 100.0;
}

if (taxamount(10, [[3, 50], [7, 10], [12, 25]]) == 2.65) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (taxamount(2, [[1, 0], [4, 25], [5, 50]]) == 0.25) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (taxamount(0, [[2, 50]]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
