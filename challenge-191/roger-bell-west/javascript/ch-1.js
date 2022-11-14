#! /usr/bin/node

"use strict"

function twicelargest(l0) {
    let l = [...l0];
    l.sort(function(a,b) {
        return b-a;
    });
    return l[0] >= l[1] * 2;
}

if (!twicelargest([1, 2, 3, 4])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (twicelargest([1, 2, 0, 5])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (twicelargest([2, 6, 3, 1])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!twicelargest([4, 5, 2, 3])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
