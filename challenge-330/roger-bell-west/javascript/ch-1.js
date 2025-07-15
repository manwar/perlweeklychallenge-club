#! /usr/bin/node

"use strict"

function cleardigits(a) {
    let out = [];
    for (let c of a.split("")) {
        if (c >= '0' && c <= '9') {
            out.pop();
        } else {
            out.push(c);
        }
    }
    return out.join("");
}

if (cleardigits('cab12') == 'c') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (cleardigits('xy99') == '') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (cleardigits('pa1erl') == 'perl') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
