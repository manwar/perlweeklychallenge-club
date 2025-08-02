#! /usr/bin/node

"use strict"

function twiceappearance(a) {
    let m = new Set;
    for (let c of a.split("")) {
        if (m.has(c)) {
            return c;
        } else {
            m.add(c);
        }
    }
    return 'x';
}

if (twiceappearance('acbddbca') == 'd') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (twiceappearance('abccd') == 'c') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (twiceappearance('abcdabbb') == 'a') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
