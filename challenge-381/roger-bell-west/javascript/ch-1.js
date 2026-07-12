#! /usr/bin/node

function range(from, to) {
    let a = [];
    for (let i = from; i <= to; i++) {
        a.push(i);
    }
    return a;
}

function samerowcolumn(a) {
    for (let row of a) {
        let notfound = new Set(range(1, row.length));
        for (let n of row) {
            notfound.delete(n)
        }
        if (notfound.size > 0) {
            return false;
        }
    }
    for (let coln = 0; coln < a[0].length; coln++) {
        let notfound = new Set(range(1, a.length));
        for (let row of a) {
            notfound.delete(row[coln]);
        }
        if (notfound.size > 0) {
            return false;
        }
    }
    return true;
}

"use strict"

if (samerowcolumn([[1, 2, 3, 4], [2, 3, 4, 1], [3, 4, 1, 2], [4, 1, 2, 3]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (samerowcolumn([[1]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!samerowcolumn([[1, 2, 5], [5, 1, 2], [2, 5, 1]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!samerowcolumn([[1, 2, 3], [1, 2, 3], [1, 2, 3]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!samerowcolumn([[1, 2, 3], [3, 1, 2], [3, 2, 1]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
