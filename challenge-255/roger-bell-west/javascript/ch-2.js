#! /usr/bin/node

"use strict"

function mostfrequentword(para, banned) {
    let words = new Map;
    for (let s of para.split(/[^A-Za-z]+/)) {
        if (s.length > 0) {
            if (words.has(s)) {
                words.set(s, words.get(s) + 1);
            } else {
                words.set(s, 1);
            }
        }
    }
    words.delete(banned);
    const m = Math.max(...words.values());
    let v = [...words.keys()].filter(w => words.get(w) == m);
    v.sort();
    return v[0];
}

if (mostfrequentword('Joe hit a ball, the hit ball flew far after it was hit.', 'hit') == 'ball') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (mostfrequentword('Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.', 'the') == 'Perl') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
