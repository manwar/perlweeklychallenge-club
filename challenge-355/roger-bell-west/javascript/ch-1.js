#! /usr/bin/node

"use strict"

function thousandseparator(a) {
    let out = "";
    const s = a.toString();
    const offset = 2 - ((s.length + 2) % 3);
    s.split("").forEach((d, i) => {
        if (i > 0 && (i + offset) % 3 == 0) {
            out += ",";
        }
        out += d;
    });
    return out;
}

if (thousandseparator(123) == '123') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (thousandseparator(1234) == '1,234') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (thousandseparator(1000000) == '1,000,000') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (thousandseparator(1) == '1') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (thousandseparator(12345) == '12,345') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
