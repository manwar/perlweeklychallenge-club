#! /usr/bin/node

"use strict"

function parsetime(t) {
    const p = t.split(':');
    return parseInt(p[0]) * 60 + parseInt(p[1]);
}

function conflictevents(a, b) {
    let r = [];
    for (let t of [a, b]) {
        const st = parsetime(t[0]);
        const en = parsetime(t[1]);
        if (st < en) {
            r.push([[st, en - 1]]);
        } else {
            r.push([
                [ st, 1440 - 1 ],
                [ 0, en - 1 ]
            ]);
        }
    }
    for (let ra of r[0]) {
        for (let rb of r[1]) {
            if (ra[0] <= rb[1] && rb[0] <= ra[1]) {
                return true;
            }
        }
    }
    return false;
}

if (conflictevents(['10:00', '12:00'], ['11:00', '13:00'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!conflictevents(['09:00', '10:30'], ['10:30', '12:00'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (conflictevents(['14:00', '15:30'], ['14:30', '16:00'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!conflictevents(['08:00', '09:00'], ['09:01', '10:00'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (conflictevents(['23:30', '00:30'], ['00:00', '01:00'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
