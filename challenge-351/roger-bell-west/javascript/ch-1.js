#! /usr/bin/node

"use strict"

function specialaverage(a0) {
    let a = [...a0];
    a.sort(function(a,b) {
        return a-b;
    });
    const min = a[0];
    const max = a[a.length-1];
    const b = a.filter(x => x != min && x != max);
    if (b.length == 0) {
        return 0;
    }
    return b.reduce((x, y) => x + y) / b.length;
}

if (specialaverage([8000, 5000, 6000, 2000, 3000, 7000]) == 5250) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (specialaverage([100000, 80000, 110000, 90000]) == 95000) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (specialaverage([2500, 2500, 2500, 2500]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (specialaverage([2000]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (specialaverage([1000, 2000, 3000, 4000, 5000, 6000]) == 3500) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
