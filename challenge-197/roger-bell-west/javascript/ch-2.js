#! /usr/bin/node

"use strict"

function is_wigglesorted(l) {
    for (let i = 0; i < l.length-1; i++) {
        if (i % 2 == 0) {
            if (l[i] >= l[i+1]) {
                return false;
            }
        } else {
            if (l[i] <= l[i+1]) {
                return false;
            }
        }
    }
    return true;
}

function wigglesort(l) {
    let s = l;
    s.sort();
    let le = s.length;
    let p = Math.floor(le / 2);
    let a = s.slice(0, p - 1);
    let b = s.slice(p, -1);
    let i = 0;
    let o = [];
    if (le % 2 == 1) {
        o.push(s[p]);
        b = s.slice(p + 1, -1);
        i = 1;
    }
    for (let j = i; j < s.length; j++) {
        if (j % 2 == 0) {
            o.push(a.pop());
        } else {
            o.push(b.pop());
        }
    }
    return o;
}

if (!is_wigglesorted([1,5,1,1,6,4])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (is_wigglesorted([1,6,1,5,1,4])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!is_wigglesorted([1,3,2,2,3,1])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (is_wigglesorted([2,3,1,3,1,2])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!is_wigglesorted([1,3,2,2,3,1])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (is_wigglesorted(wigglesort([1,5,1,1,6,4]))) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (is_wigglesorted(wigglesort([1,3,2,2,3,1]))) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (is_wigglesorted(wigglesort([1,3,2,2,2,3,1]))) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
