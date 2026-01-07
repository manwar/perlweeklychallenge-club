#! /usr/bin/node

"use strict"

function windows(a, size, offset) {
    let out = [];
    for (let i = 0; i <= a.length - size; i += offset) {
        let w = [];
        for (let j = 0; j < size; j++) {
            if (i + j < a.length) {
                w.push(a[i + j]);
            }
        }
        out.push(w);
    }
    return out;
}

function mountainarray(a) {
    let state = 0;
    for (let b of windows(a, 2, 1)) {
        if (b[1] > b[0]) {
            if (state == 0 || state == 1) {
                state = 1;
            } else {
                return false;
            }
        } else if (b[1] < b[0]) {
            if (state == 1 || state == 2) {
                state = 2;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
    return state == 2;
}

if (!mountainarray([1, 2, 3, 4, 5])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (mountainarray([0, 2, 4, 6, 4, 2, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!mountainarray([5, 4, 3, 2, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!mountainarray([1, 3, 5, 5, 4, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (mountainarray([1, 3, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
