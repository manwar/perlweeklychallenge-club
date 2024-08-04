#! /usr/bin/node

"use strict"

function countasterisks(a) {
    let out = 0
    let active = true
    for (let c of a.split("")) {
        switch (c) {
        case '|':
            active = !active;
            break;
        case '*':
            if (active) {
                out += 1;
            }
        }
    }
    return out
}

if (countasterisks('p|*e*rl|w**e|*ekly|') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (countasterisks('perl') == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (countasterisks('th|ewe|e**|k|l***ych|alleng|e') == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
