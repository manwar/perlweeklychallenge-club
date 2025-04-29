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

function wordcount(a) {
    let ct = 0;
    for (let w of a) {
        if (is_vowel(w.slice(1)) || is_vowel(w.slice(-1))) {
            ct++;
        }
    }
    return ct;
}

if (wordcount(['unicode', 'xml', 'raku', 'perl']) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (wordcount(['the', 'weekly', 'challenge']) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (wordcount(['perl', 'python', 'postgres']) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
