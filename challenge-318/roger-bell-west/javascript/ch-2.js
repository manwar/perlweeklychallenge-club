#! /usr/bin/node

"use strict"

function arrcmp(a, b) {
    if (a.length != b.length) {
        return false;
    }
    for (let i = 0; i < a.length; i++) {
        if (a[i] != b[i]) {
            return false;
        }
    }
    return true;
}

function reverseequals(a, b) {
    if (arrcmp(a, b)) {
        return true;
    }
    for (let i = 0; i < a.length - 1; i++) {
        for (let j = i + 1; j < a.length; j++) {
            let c = [...a];
            for (let x = i; x <= j; x++) {
                c[x] = a[j - (x - i)];
            }
            if (arrcmp(c, b)) {
                return true;
            }
        }
    }
    return false;
}

if (reverseequals([3, 2, 1, 4], [1, 2, 3, 4])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!reverseequals([1, 3, 4], [4, 1, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reverseequals([2], [2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
