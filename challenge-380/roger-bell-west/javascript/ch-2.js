#! /usr/bin/node

"use strict"

function reversedegree(a) {
    let t = 0;
    const z0 = "z".charCodeAt(0) + 1;
    a.split("").forEach((c, i) => {
        t += (z0 - c.charCodeAt(0)) * (i + 1);
    });
    return t;
}

if (reversedegree('z') == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reversedegree('a') == 26) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reversedegree('bbc') == 147) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reversedegree('racecar') == 560) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reversedegree('zyx') == 14) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
