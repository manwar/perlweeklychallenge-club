#! /usr/bin/node

"use strict"

function reverseprefix(a, f) {
    let c = a.split('');
    const fc = f.split('')[0];
    const p = c.indexOf(fc);
    if (p >= 0) {
        let jr = c.slice(0, p + 1);
        jr.reverse();
        let cr = c.slice(p + 1);
        c = jr.concat(cr);
    }
    return c.join("");
}

if (reverseprefix('programming', 'g') == 'gorpramming') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reverseprefix('hello', 'h') == 'hello') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reverseprefix('abcdefghij', 'h') == 'hgfedcbaij') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reverseprefix('reverse', 's') == 'srevere') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reverseprefix('perl', 'r') == 'repl') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
