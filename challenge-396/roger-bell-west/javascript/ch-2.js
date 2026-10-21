#! /usr/bin/node

"use strict"

function trionicarray(a) {
    var state = 0
    var prev = a[0]
    for (let i = 1; i < a.length; i++) {
        const n = a[i];
        var dir = 0;
        if (n > prev) {
            dir = 1;
        } else if (n < prev) {
            dir = -1;
        }
        if (dir == 0) {
            return false;
        } else {
            switch(state) {
            case 0:
                if (dir == 1) {
                    state = 1;
                } else {
                    return false;
                }
                break;
            case 1:
                if (dir == -1) {
                    state = 2;
                }
                break;
            case 2:
                if (dir == 1) {
                    state = 3;
                }
                break;
            case 3:
                if (dir == -1) {
                    return false;
                }
                break;
            default:
                return false;
            }
            prev = n;
        }
    }
    return state == 3;
}

if (trionicarray([1, 3, 5, 4, 2, 6, 8])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!trionicarray([1, 4, 4, 2, 1, 3, 5])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (trionicarray([2, 10, 3, 1, 9])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!trionicarray([1, 2, 3, 4, 3, 2, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!trionicarray([1, 3, 2, 4, 1, 5, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
