#! /usr/bin/node

"use strict"

function backspacecompare(a, b) {
    let sa = [];
    for (let i of [a, b]) {
        let oa = [];
        i.split("").forEach((c, _) => {
            if (c == '#') {
                oa.pop();
            } else {
                oa.push(c);
            }
        });
        sa.push(oa.join(''));
    }
    return sa[0] == sa[1];
}

if (backspacecompare('ab#c', 'ad#c')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (backspacecompare('ab##', 'a#b#')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!backspacecompare('a#b', 'c')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
