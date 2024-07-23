#! /usr/bin/node

"use strict"

function splitstring(a) {
    let n = 0
    for (let cc of a.toLowerCase().split("")) {
        switch (cc.toLowerCase()) {
        case "a":
        case "e":
        case "i":
        case "o":
        case "u":
            n++;
        }
    }
    return n % 2 == 0
}

if (!splitstring('perl')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (splitstring('book')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (splitstring('goodmorning')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
