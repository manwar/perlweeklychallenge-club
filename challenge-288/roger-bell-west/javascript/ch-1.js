#! /usr/bin/node

"use strict"

function closestpalindrome(a) {
    const n = parseInt(a);
    let delta = -1;
    while (true) {
        const q = (n + delta).toString();
        if (q == q.split("").reverse().join("")) {
            return q;
        }
        delta = -delta;
        if (delta < 0) {
            delta -= 1;
        }
    }
}

if (closestpalindrome('123') == '121') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (closestpalindrome('2') == '1') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (closestpalindrome('1400') == '1441') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (closestpalindrome('1000') == '999') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
