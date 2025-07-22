#! /usr/bin/node

"use strict"

function buddystrings(a, b) {
    let ac = a.split("");
    for (let i = 0; i < a.length - 1; i++) {
        for (let j = i + 1; j < a.length; j++) {
            let acx = a.split("");
            acx[i] = ac[j];
            acx[j] = ac[i];
            if (acx.join("") == b) {
                return true;
            }
        }
    }
    return false;
}

if (buddystrings('fuck', 'fcuk')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!buddystrings('love', 'love')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (buddystrings('fodo', 'food')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (buddystrings('feed', 'feed')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
