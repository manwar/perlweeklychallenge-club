#! /usr/bin/node

"use strict"

function summation(ls0) {
    let ls = ls0
    while (ls.length > 1) {
        let lv = []
        for (let i = 1; i < ls.length; i++) {
            let s = 0
            for (let j = 1; j <= i; j++) {
                s += ls[j]
            }
            lv.push(s)
        }
        ls = lv
    }
    return ls[0]
}

if (summation([1,2,3,4,5]) == 42) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (summation([1,3,5,7,9]) == 70) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write("\n");
