#! /usr/bin/node

"use strict"

function secondlargestdigit(a) {
    const p = new Set(a.split("").filter(x => x >= '0' && x <= '9'));
    let k = new Array(...p);
    k.sort();
    k.reverse();
    if (k.length > 1) {
        return 0 + k[1];
    } else {
        return -1;
    }
}

if (secondlargestdigit('aaaaa77777') == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (secondlargestdigit('abcde') == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (secondlargestdigit('9zero8eight7seven9') == 8) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (secondlargestdigit('xyz9876543210') == 8) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (secondlargestdigit('4abc4def2ghi8jkl2') == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
