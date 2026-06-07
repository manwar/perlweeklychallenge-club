#! /usr/bin/node

"use strict"

function cs2xy(a) {
    const x = a.charCodeAt(0) - 'a'.charCodeAt(0);
    const y = a.charCodeAt(1) - '1'.charCodeAt(0);
    return [x, y];
}

function checkcolor(a) {
    const xy = cs2xy(a);
    return (xy[0] + xy[1]) % 2 == 1;
}

function chessboardsquares(a, b) {
    return checkcolor(a) == checkcolor(b);
}

if (chessboardsquares('a7', 'f4')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!chessboardsquares('c1', 'e8')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!chessboardsquares('b5', 'h2')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (chessboardsquares('f3', 'h1')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!chessboardsquares('a1', 'g8')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
