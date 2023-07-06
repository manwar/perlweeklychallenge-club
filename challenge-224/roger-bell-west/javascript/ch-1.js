#! /usr/bin/node

"use strict"

function word2map(word) {
    let m = new Map();
    for (let c of word.toLowerCase()) {
        if (m.has(c)) {
            m.set(c, m.get(c) + 1);
        } else {
            m.set(c, 1);
        }
    }
    return m;
}

function specialnotes(chars, word) {
    const cm = word2map(chars);
    const f = word2map(word);
    let valid = true;
    for (let c of f.keys()) {
        if (!cm.has(c) ||
            f.get(c) > cm.get(c)) {
            valid = false;
            break;
        }
    }
    return valid;
}

if (!specialnotes('abc', 'xyz')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (specialnotes('scriptinglanguage', 'perl')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (specialnotes('aabbcc', 'abc')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
