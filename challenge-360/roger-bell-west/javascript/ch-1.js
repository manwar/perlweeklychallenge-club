#! /usr/bin/node

"use strict"

function textjustifier(intxt, width) {
    let working = new Array(width).fill("*");
    const offset = Math.floor((width - intxt.length) / 2);
    intxt.split("").forEach((c, i) => {
        working[i + offset] = c;
    });
    return working.join("");
}

if (textjustifier('Hi', 5) == '*Hi**') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (textjustifier('Code', 10) == '***Code***') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (textjustifier('Hello', 9) == '**Hello**') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (textjustifier('Perl', 4) == 'Perl') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (textjustifier('A', 7) == '***A***') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (textjustifier('', 5) == '*****') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
