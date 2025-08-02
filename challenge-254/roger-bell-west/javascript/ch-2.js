#! /usr/bin/node

"use strict"

function is_vowel(c) {
    switch (c.toLowerCase()) {
    case "a":
        return true;
    case "e":
        return true;
    case "i":
        return true;
    case "o":
        return true;
    case "u":
        return true;
    default:
        return false;
    }
}

function reversevowels(a) {
    const p = a.split("");
    const q = p.filter(c => is_vowel(c));
    let qi = q.length;
    let o = [];
    for (let c of p) {
        if (is_vowel(c)) {
            qi -= 1;
            let nc = q[qi];
            if (c.toUpperCase() == c) {
                nc = nc.toUpperCase();
            } else {
                nc = nc.toLowerCase();
            }
            o.push(nc);
        } else {
            o.push(c);
        }
    }
    return o.join("");
}

if (reversevowels('Raku') == 'Ruka') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reversevowels('Perl') == 'Perl') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reversevowels('Julia') == 'Jaliu') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reversevowels('Uiua') == 'Auiu') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
