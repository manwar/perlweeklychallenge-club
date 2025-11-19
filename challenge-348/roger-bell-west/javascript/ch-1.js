#! /usr/bin/node

"use strict"

function stringalike(a) {
    if (a.length % 2 == 1) {
        return false;
    }
    let vt = 0;
    let mode = 1;
    let av = false;
    a.toLowerCase().split("").forEach((c, i) => {
        if (i * 2 == a.length) {
            mode = -1;
        }
        if (c.match(/[aeiou]/)) {
            av = true;
            vt += mode;
        }
    });
    return av && (vt == 0);
}

if (!stringalike('textbook')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (stringalike('book')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (stringalike('AbCdEfGh')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!stringalike('rhythmmyth')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!stringalike('UmpireeAudio')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
