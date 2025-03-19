#! /usr/bin/node

"use strict"

function reverseletters(a) {
    var vout = a.split("");
    var letterslots = [];
    var letters = [];
    a.split("").forEach((c, i) => {
        if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
            letterslots.push(i);
            letters.push(c);
        } else {
            vout[i] = c;
        }
    });
    for (let i of letterslots) {
        vout[i] = letters.pop();
    }
    return vout.join("");
}

if (reverseletters('p-er?l') == 'l-re?p') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reverseletters('wee-k!L-y') == 'yLk-e!e-w') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reverseletters('_c-!h_all-en!g_e') == '_e-!g_nel-la!h_c') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
