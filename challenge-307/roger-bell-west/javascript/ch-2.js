#! /usr/bin/node

"use strict"

function findanagrams(a) {
    let b = [];
    for (let s of a) {
        let c = s.split("");
        c.sort();
        b.push(c.join(""));
    }
    let out = 1;
    for (let i = 1; i < b.length; i++) {
        if (b[i - 1] != b[i]) {
            out += 1;
        }
    }
    return out;
}

if (findanagrams(['acca', 'dog', 'god', 'perl', 'repl']) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (findanagrams(['abba', 'baba', 'aabb', 'ab', 'ab']) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
