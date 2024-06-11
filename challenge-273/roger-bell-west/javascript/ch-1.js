#! /usr/bin/node

"use strict"

function percentageofcharacter(a, c) {
    const d = a.length;
    const n = 100 * a.split("").filter(n => n == c).length;
    return Math.floor(n / d + 0.5);
}

if (percentageofcharacter('perl', 'e') == 25) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (percentageofcharacter('java', 'a') == 50) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (percentageofcharacter('python', 'm') == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (percentageofcharacter('ada', 'a') == 67) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (percentageofcharacter('ballerina', 'l') == 22) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (percentageofcharacter('analitik', 'k') == 13) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
