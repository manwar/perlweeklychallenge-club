#! /usr/bin/node

"use strict"

function greatestenglishletter(a) {
    let m = new Map;
    for (let c of a.split("")) {
        const uc = c.toUpperCase();
        let v = (c == uc) ? 1 : 2;
        if (m.has(uc)) {
            v |= m.get(uc);
        }
        m.set(uc, v);
    }
    let s = [...m.keys()].filter( k => m.get(k) == 3 );
    if (s.length == 0) {
        return ""
    }
    s.sort();
    return s[s.length - 1];
}


if (greatestenglishletter('PeRlwEeKLy') == 'L') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (greatestenglishletter('ChaLlenge') == 'L') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (greatestenglishletter('The') == '') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
