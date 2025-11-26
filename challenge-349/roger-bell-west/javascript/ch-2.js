#! /usr/bin/node

"use strict"

function counterify(a) {
    let cc = new Map;
    for (let x of a) {
        if (!cc.has(x)) {
            cc.set(x, 0);
        }
        cc.set(x, cc.get(x) + 1);
    }
    return cc;
}

function defget(m, v) {
    return m.get(v) || 0;
}

function meetingpoint(a) {
    const c = counterify(a.split(""));
    return defget(c, "U") == defget(c, "D") &&
        defget(c, "L") == defget(c, "R");
}

if (!meetingpoint('ULD')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (meetingpoint('ULDR')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!meetingpoint('UUURRRDDD')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (meetingpoint('UURRRDDLLL')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!meetingpoint('RRUULLDDRRUU')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
