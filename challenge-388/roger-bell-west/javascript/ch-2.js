#! /usr/bin/node

"use strict"

function secretsanta(n) {
    switch(n) {
    case 0:
        return 1;
        break;
    case 1:
        return 0;
        break;
    default:
        return (n - 1) * (secretsanta(n - 1) + secretsanta(n - 2));
    }
}

if (secretsanta(1) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (secretsanta(2) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (secretsanta(3) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (secretsanta(4) == 9) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (secretsanta(5) == 44) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
