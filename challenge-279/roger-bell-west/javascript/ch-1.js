#! /usr/bin/node

"use strict"

function sortletters(a, c) {
    let out = Array(a.length);
    a.forEach((l, i) => {
        out[c[i] - 1] = l;
    });
    return out.join("");
}

if (sortletters(['R', 'E', 'P', 'L'], [3, 2, 1, 4]) == 'PERL') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sortletters(['A', 'U', 'R', 'K'], [2, 4, 1, 3]) == 'RAKU') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sortletters(['O', 'H', 'Y', 'N', 'P', 'T'], [5, 4, 2, 6, 1, 3]) == 'PYTHON') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
