#! /usr/bin/node

"use strict"

function baftera(a) {
    const firstb = a.indexOf('b');
    if (firstb == -1) {
        return false;
    }
    const lasta = a.lastIndexOf('a');
    if (lasta == -1) {
        return true;
    }
    return lasta < firstb;
}

if (baftera('aabb')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!baftera('abab')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!baftera('aaa')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (baftera('bbb')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
