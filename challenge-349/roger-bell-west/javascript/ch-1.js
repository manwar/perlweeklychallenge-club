#! /usr/bin/node

"use strict"

function powerstring(a) {
    let mx = 0;
    let prev = "A";
    let cur = 0;
    for (let c of a.split("")) {
        if (cur > 0 && c == prev) {
            cur += 1;
        } else {
            cur = 1;
            prev = c;
        }
        mx = Math.max(mx, cur);
    }
    return mx;
}

if (powerstring('textbook') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (powerstring('aaaaa') == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (powerstring('hoorayyy') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (powerstring('x') == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (powerstring('aabcccddeeffffghijjk') == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
