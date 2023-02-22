#! /usr/bin/node

"use strict"

function thirdhighest(l) {
    let v = [...new Set(l)];
    v.sort(function(a,b) {
        return b-a;
    });
    if (v.length == 0) {
        return 0;
    } else if (v.length <= 2) {
        return v[0];
    } else {
        return v[2];
    }
}

if (thirdhighest([5, 3, 4]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (thirdhighest([5, 6]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (thirdhighest([5, 4, 4, 3]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
