#! /usr/bin/node

"use strict"

function equalstrings(a) {
    const ax = new Set(a);
    let ca = [];
    for (let x of ax) {
        ca.push(x.split(""));
    }
    const mmlen = Math.min(...ca.map(x => x.length));
    let si = 0;
    for (let i = 0; i < mmlen; i++) {
        si = i;
        for (let s = 1; s < ca.length; s++) {
            if (ca[0][i] != ca[s][i]) {
                if (i == 0) {
                    return -1;
                }
                si -= 1;
                break;
            }
        }
    }
    return a.map(x => x.length).reduce((x, y) => x + y) - a.length * (si + 1);
}

if (equalstrings(['abc', 'abb', 'ab']) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (equalstrings(['ayz', 'cyz', 'xyz']) == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (equalstrings(['yza', 'yzb', 'yzc']) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
