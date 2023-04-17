#! /usr/bin/node

"use strict"

function jumpingletters(word, jump) {
    var s = ""
    for (let i = 0; i < jump.length; i++) {
        let c = word.charCodeAt(i);
        let d = c + jump[i] % 26;
        if ((c <= 90 && d > 90) || d > 122) {
            d -= 26;
        }
        s += String.fromCharCode(d);
    }
    return s;
}

if (jumpingletters('Perl', [2, 22, 19, 9]) == 'Raku') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (jumpingletters('Raku', [24, 4, 7, 17]) == 'Perl') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
