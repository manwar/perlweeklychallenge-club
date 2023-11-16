#! /usr/bin/node

"use strict"

function floorsum(a) {
    let n = 0;
    for (let iv of a) {
        for (let jv of a) {
            n += Math.floor(iv / jv);
        }
    }
    return n;
}

if (floorsum([2, 5, 9]) == 10) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (floorsum([7, 7, 7, 7, 7, 7, 7]) == 49) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
