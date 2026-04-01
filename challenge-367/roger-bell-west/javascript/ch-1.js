#! /usr/bin/node

"use strict"

function maxoddbinary(a) {
    let ones = 0;
    let zeroes = 0;
    for (let c of a.split('')) {
        if (c == '0') {
            zeroes++;
        } else if (c == '1') {
            ones++;
        }
    }
    if (ones < 1) {
        return "";
    }
    let out = "";
    for (let i = 1; i < ones; i++) {
        out += "1";
    }
    for (let i = 0; i < zeroes; i++) {
        out += "0";
    }
    out += "1";
    return out;
}

if (maxoddbinary('1011') == '1101') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxoddbinary('100') == '001') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxoddbinary('111000') == '110001') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxoddbinary('0101') == '1001') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxoddbinary('1111') == '1111') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
