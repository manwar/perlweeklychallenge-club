#! /usr/bin/node

"use strict"

function consistentstrings(a, v) {
    const vs = new Set(v.split(""));
    return a.filter(s => Array.from(new Set(s.split(""))).every(c => vs.has(c))).length;
}

if (consistentstrings(['ad', 'bd', 'aaab', 'baa', 'badab'], 'ab') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (consistentstrings(['a', 'b', 'c', 'ab', 'ac', 'bc', 'abc'], 'ab') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (consistentstrings(['cc', 'acd', 'b', 'ba', 'bac', 'bad', 'ac', 'd'], 'cad') == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
