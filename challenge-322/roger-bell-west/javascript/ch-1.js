#! /usr/bin/node

"use strict"

function formatstring(a, n) {
    const p = a.split("").filter(x => x != '-');
    let r = p.length % n;
    if (r == 0) {
        r += n;
    }
    let o = "";
    p.forEach((c, i) => {
        if (r == i) {
            o += '-';
            r += n;
        }
        o += c;
    });
    return o;
}

if (formatstring('ABC-D-E-F', 3) == 'ABC-DEF') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (formatstring('A-BC-D-E', 2) == 'A-BC-DE') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (formatstring('-A-B-CD-E', 4) == 'A-BCDE') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
