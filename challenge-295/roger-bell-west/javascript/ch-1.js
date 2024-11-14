#! /usr/bin/node

"use strict"

function wordbreak(a, words) {
    let queue = [];
    queue.push(a);
    while (queue.length > 0) {
        const remnant = queue.shift();
        if (remnant.length == 0) {
            return true;
        } else {
            for (let candidate of words) {
                if (remnant.indexOf(candidate) == 0) {
                    queue.push(remnant.substring(candidate.length, remnant.length));
                }
            }
        }
    }
    return false;
}

if (wordbreak('weeklychallenge', ['challenge', 'weekly'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (wordbreak('perlrakuperl', ['raku', 'perl'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!wordbreak('sonsanddaughters', ['sons', 'sand', 'daughters'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
