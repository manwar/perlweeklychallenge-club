#! /usr/bin/node

"use strict"

function acronym(strs, chk) {
    return strs.map(x => x.substring(0, 1)).join("").toLowerCase() ==
        chk.toLowerCase()
}

if (acronym(['Perl', 'Python', 'Pascal'], 'ppp')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!acronym(['Perl', 'Raku'], 'rp')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (acronym(['Oracle', 'Awk', 'C'], 'oac')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
