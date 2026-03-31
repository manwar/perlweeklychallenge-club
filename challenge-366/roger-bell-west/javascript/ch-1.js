#! /usr/bin/node

"use strict"

function countprefixes(a, b) {
    return a.filter(x => b.startsWith(x)).length;
}

if (countprefixes(['a', 'ap', 'app', 'apple', 'banana'], 'apple') == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (countprefixes(['cat', 'dog', 'fish'], 'bird') == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (countprefixes(['hello', 'he', 'hell', 'heaven', 'he'], 'hello') == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (countprefixes(['', 'code', 'coding', 'cod'], 'coding') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (countprefixes(['p', 'pr', 'pro', 'prog', 'progr', 'progra', 'program'], 'program') == 7) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
