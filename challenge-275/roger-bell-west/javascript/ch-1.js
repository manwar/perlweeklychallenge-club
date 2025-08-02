#! /usr/bin/node

"use strict"

function brokenkeys(a, k) {
    let out = 0;
    const failset = new Set(k.map(c => c.toLowerCase()))
    for (let word of a.split(" ")) {
        const wordset = new Set(word.toLowerCase().split(""));
        const intersect = new Set([...failset].filter(i => wordset.has(i)));
        if (intersect.size == 0) {
            out++;
        }
    }
    return out;
}

if (brokenkeys('Perl Weekly Challenge', ['l', 'a']) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (brokenkeys('Perl and Raku', ['a']) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (brokenkeys('Well done Team PWC', ['l', 'o']) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
