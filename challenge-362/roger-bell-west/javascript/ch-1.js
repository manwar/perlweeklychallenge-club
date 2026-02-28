#! /usr/bin/node

"use strict"

function echochamber(a) {
    let out = "";
    a.split("").forEach((c, i) => {
        out += c.repeat(i + 1);
    });
    return out;
}

if (echochamber('abca') == 'abbcccaaaa') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (echochamber('xyz') == 'xyyzzz') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (echochamber('code') == 'coodddeeee') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (echochamber('hello') == 'heelllllllooooo') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (echochamber('a') == 'a') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
