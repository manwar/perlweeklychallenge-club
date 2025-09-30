#! /usr/bin/node

"use strict"

function brokenkeyboard(a, b) {
    const bk = new Set(b.map( k => k.toLowerCase().split('')[0] ));
    let ct = 0;
    for (let w of a.split(" ")) {
        const nk = new Set(w.toLowerCase().split(""));
        const intersect = new Set([...bk].filter(i => nk.has(i)));
        if (intersect.size == 0) {
            ct += 1;
        }
    }
    return ct;
}

if (brokenkeyboard('Hello World', ['d']) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (brokenkeyboard('apple banana cherry', ['a', 'e']) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (brokenkeyboard('Coding is fun', []) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (brokenkeyboard('The Weekly Challenge', ['a', 'b']) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (brokenkeyboard('Perl and Python', ['p']) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
