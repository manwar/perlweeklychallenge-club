#! /usr/bin/node

"use strict"

function oddoneout(a) {
    let ct = 0;
    for (let s of a) {
        let p = s.split("");
        p.sort();
        if (p.join("") != s) {
            ct += 1;
        }
    }
    return ct;
}

if (oddoneout(['abc', 'xyz', 'tsu']) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (oddoneout(['rat', 'cab', 'dad']) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (oddoneout(['x', 'y', 'z']) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
