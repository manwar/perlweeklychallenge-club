#! /usr/bin/node

"use strict"

function lexicographic(a) {
    let t = 0;
    for (let st of a) {
        let q = st.split("");
        q.sort();
        if (q.join("") == st) {
            continue;
        }
        q.reverse();
        if (q.join("") == st) {
            continue;
        }
        t += 1;
    }
    return t;
}

if (lexicographic(['abc', 'bce', 'cae']) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (lexicographic(['yxz', 'cba', 'mon']) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
