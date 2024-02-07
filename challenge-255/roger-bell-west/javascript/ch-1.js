#! /usr/bin/node

"use strict"

function oddcharacter(s, t) {
    let ss = new Map;
    for (let c of s.split("")) {
        if (ss.has(c)) {
            ss.set(c, ss.get(c) + 1);
        } else {
            ss.set(c, 1);
        }
    }
    for (let c of t.split("")) {
        if (ss.has(c)) {
            const p = ss.get(c) - 1;
            if (p == 0) {
                ss.delete(c);
            } else {
                ss.set(c, p);
            }
        } else {
            return c;
        }
    }
    return '@';
}

if (oddcharacter('Perl', 'Preel') == 'e') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (oddcharacter('Weekly', 'Weeakly') == 'a') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (oddcharacter('Box', 'Boxy') == 'y') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
