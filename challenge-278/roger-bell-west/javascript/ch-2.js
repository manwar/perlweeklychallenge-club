#! /usr/bin/node

"use strict"

function reverseword(a, c) {
    const m = a.indexOf(c);
    if (m == -1) {
        return a;
    }
    let b = a.slice(0, m + 1).split("");
    b.sort();
    b.push(...a.slice(m + 1).split(""));
    return b.join("");
}

if (reverseword('challenge', 'e') == 'acehllnge') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reverseword('programming', 'a') == 'agoprrmming') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reverseword('champion', 'b') == 'champion') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
