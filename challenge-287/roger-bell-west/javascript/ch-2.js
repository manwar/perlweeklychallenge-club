#! /usr/bin/node

"use strict"

function validnumber(a) {
    const integer = "[-+]?[0-9]+";
    const float = "[-+]?([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)";
    const exponential =
        "(" + integer + "|" + float + ")[Ee]" + integer;
    const number =
        "^(" + integer + "|" + float + "|" + exponential + ")$";
    const rx = new RegExp(number);
    return a.search(rx) != -1;
}

if (validnumber('1')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!validnumber('a')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!validnumber('.')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!validnumber('1.2e4.2')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (validnumber('-1.')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (validnumber('+1E-8')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (validnumber('.44')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
