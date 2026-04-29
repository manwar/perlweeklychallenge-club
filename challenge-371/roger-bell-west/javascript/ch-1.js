#! /usr/bin/node

"use strict"

// by VLAZ
// https://stackoverflow.com/a/59322890
function toWindows(inputArray, size) {
  return Array.from(
    {length: inputArray.length - (size - 1)}, //get the appropriate length
    (_, index) => inputArray.slice(index, index+size) //create the windows
  )
}

function missingletter(a) {
    const c = a.split("").filter(x => x != " ").map(x => x.codePointAt(0));
    let d = [];
    for (let i of toWindows(c, 2)) {
        if (i[0] == 63 || i[1] == 63) {
            d.push(0);
        } else {
            d.push(i[1] - i[0]);
        }
    }
    let ch = 0;
    d.forEach((delta, n) => {
        if (ch == 0 && delta == 0) {
            if (n < 2) {
                ch = c[n + 2] - d[n + 2];
            } else {
                ch = c[n] + d[n - 2];
            }
        }
    });
    return String.fromCharCode(ch);
}

if (missingletter('a c ? g i') == 'e') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (missingletter('a d ? j m') == 'g') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (missingletter('a e ? m q') == 'i') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (missingletter('a c f ? k') == 'h') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (missingletter('b e g ? l') == 'j') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
