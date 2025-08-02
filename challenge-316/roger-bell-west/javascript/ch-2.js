#! /usr/bin/node

"use strict"

function subsequence(a, b) {
    let l = a;
    let s = b;
    if (a.length < b.length) {
        l = b;
        s = a;
    }
    const st = s.split("");
    let si = 0;
    for (let c of l.split("")) {
        if (c == st[si]) {
            si += 1;
            if (si >= st.length) {
                return true;
            }
        }
    }
    return false;
}

if (subsequence('uvw', 'bcudvew')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!subsequence('aec', 'abcde')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (subsequence('sip', 'javascript')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
