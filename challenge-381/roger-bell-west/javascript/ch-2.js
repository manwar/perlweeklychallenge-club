#! /usr/bin/node

"use strict"

function smallergreaterelement(a) {
    const mn = Math.min(...a);
    const mx = Math.max(...a);
    return a.filter(x => x != mn && x != mx).length;
}

if (smallergreaterelement([2, 4]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (smallergreaterelement([1, 1, 1, 1]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (smallergreaterelement([1, 1, 4, 8, 12, 12]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (smallergreaterelement([3, 6, 6, 9]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (smallergreaterelement([0, -5, 10, -2, 4]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
