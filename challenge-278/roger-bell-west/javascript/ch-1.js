#! /usr/bin/node

"use strict"

function sortstring(a) {
    let words = a.split(" ");
    let out = Array(words.length);
    const re = /^(.*?)([0-9]+)$/;
    for (let w of words) {
        let match = w.match(re);
        let index = match[2] - 1;
        out[index] = match[1];
    }
    return out.join(" ");
}

if (sortstring('and2 Raku3 cousins5 Perl1 are4') == 'Perl and Raku are cousins') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sortstring('guest6 Python1 most4 the3 popular5 is2 language7') == 'Python is the most popular guest language') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sortstring('Challenge3 The1 Weekly2') == 'The Weekly Challenge') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
