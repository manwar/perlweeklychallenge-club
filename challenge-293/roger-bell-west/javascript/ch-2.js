#! /usr/bin/node

"use strict"

function boomerang(a) {
    let delta = [];
    // coincident points
    for (let ij = 0; ij <= 1; ij++) {
        for (let ik = ij + 1; ik <= 2; ik++) {
            if (a[ij][0] == a[ik][0] && a[ij][1] == a[ik][1]) {
                return false;
            }
        }
        delta.push([a[ij + 1][0] - a[0][0], a[ij + 1][1] - a[0][1]]);
    }
    // all on the same vertical line
    if (delta[0][0] == 0 && delta[1][0] == 0) {
        return false;
    }
    // just one vertical line
    if (delta[0][0] == 0 || delta[1][0] == 0) {
        return true;
    }
    let m = delta[0][1] / delta[0][0];
    let c = a[0][1] - a[0][0] * m;
    return a[2][1] != a[2][0] * m + c;
}

if (boomerang([[1, 1], [2, 3], [3, 2]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!boomerang([[1, 1], [2, 2], [3, 3]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (boomerang([[1, 1], [1, 2], [2, 3]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!boomerang([[1, 1], [1, 2], [1, 3]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!boomerang([[1, 1], [2, 1], [3, 1]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (boomerang([[0, 0], [2, 3], [4, 5]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
