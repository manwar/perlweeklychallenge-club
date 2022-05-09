#! /usr/bin/node

"use strict"

function sumbitwise(ls) {
    let s = 0
    for (let i = 0; i < ls.length - 1; i++) {
        for (let j = i + 1; j < ls.length; j++) {
            s += ls[i] & ls[j]
        }
    }
    return s
}

if (sumbitwise([1,2,3]) == 3) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (sumbitwise([2,3,4]) == 2) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write("\n");
