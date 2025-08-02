#! /usr/bin/node

function friendlystrings(a, b) {
    const aa = a.split("");
    for (let i = 0; i < a.length - 1; i++) {
        for (let j = i + 1; j < a.length; j++) {
            let cc = a.split("");
            cc[i] = aa[j]
            cc[j] = aa[i]
            if (cc.join("") == b) {
                return true;
            }
        }
    }
    return false;
}

"use strict"

if (friendlystrings('desc', 'dsec')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (friendlystrings('fuck', 'fcuk')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!friendlystrings('poo', 'eop')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (friendlystrings('stripe', 'sprite')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
