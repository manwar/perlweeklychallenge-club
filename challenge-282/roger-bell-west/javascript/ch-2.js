#! /usr/bin/node

"use strict"

function changingkeys(a) {
    let oc = 'x';
    let out = 0;
    a.toLowerCase().split("").forEach((c, i) => {
        if (i == 0) {
            oc = c;
        } else if (c != oc) {
            oc = c;
            out ++;
        }
    });
    return out;
}

if (changingkeys('pPeERrLl') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (changingkeys('rRr') == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (changingkeys('GoO') == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
