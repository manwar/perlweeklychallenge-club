#! /usr/bin/node

"use strict"

function acronyms(a, b) {
    let os = "";
    for (let c of a) {
        os += c.charAt(0);
    }
    return os == b;
}

if (acronyms(['Perl', 'Weekly', 'Challenge'], 'PWC')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (acronyms(['Bob', 'Charlie', 'Joe'], 'BCJ')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!acronyms(['Morning', 'Good'], 'MM')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
