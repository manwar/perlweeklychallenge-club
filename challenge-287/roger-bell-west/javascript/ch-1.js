#! /usr/bin/node

"use strict"

function strongpassword(a) {
    let ctypes = new Map();
    let reps = 0;
    let rep = 0;
    let old = '@';
    let changes = [];
    a.split("").forEach((c, i) => {
        if (i > 0 && c == old) {
            rep += 1;
            if (rep >= 2) {
                reps += 1;
            }
        } else {
            rep = 0;
            old = c;
        }
        let t = 'n';
        if (c >= 'A' && c <= 'Z') {
            t = 'u';
        } else if (c >= 'a' && c <= 'z') {
            t = 'l';
        } else if (c >= '0' && c <= '9') {
            t = 'd';
        }
        if (!ctypes.has(t)) {
            ctypes.set(t, 0);
        }
        ctypes.set(t, ctypes.get(t) + 1);
    });
    changes.push(reps);
    ctypes.delete('n');
    let k = ctypes.keys().size;
    if (k < 3) {
        let spare = ctypes.values().reduce((x, y) => x + y) - k;
        if (spare < 0) {
            changes.push(-spare);
        }
    }
    if (a.length < 6) {
        changes.push(6 - a.length);
    }
    return Math.max(...changes);
}

if (strongpassword('a') == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (strongpassword('aB2') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (strongpassword('PaaSW0rd') == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (strongpassword('Paaasw0rd') == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (strongpassword('aaaaa') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
