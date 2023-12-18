#! /usr/bin/node

"use strict"

function mostfrequentletterpair(s) {
    let f = new Map;
    for (let i = 0; i < s.length - 1; i++) {
        let pair = s.substring(i, i + 2);
        if (f.has(pair)) {
            f.set(pair,f.get(pair)+1);
        } else {
            f.set(pair,1);
        }
    }
    const m = Math.max(...f.values());
    let l = Array.from(f.keys()).filter(i => f.get(i) == m);
    l.sort();
    return l[0];
}

if (mostfrequentletterpair('abcdbca') == 'bc') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (mostfrequentletterpair('cdeabeabfcdfabgcd') == 'ab') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
