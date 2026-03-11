#! /usr/bin/node

"use strict"

function goalparser(a) {
    let out = "";
    let s = 0;
    while (s < a.length) {
        if (a.substring(s).startsWith("G")) {
            s += 1;
            out += "G";
        } else if (a.substring(s).startsWith("()")) {
            s += 2;
            out += "o";
        } else if (a.substring(s).startsWith("(al)")) {
            s += 4;
            out += "al";
        } else {
            return "";
        }
    }
    return out;
}

if (goalparser('G()(al)') == 'Goal') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goalparser('G()()()()(al)') == 'Gooooal') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goalparser('(al)G(al)()()') == 'alGaloo') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goalparser('()G()G') == 'oGoG') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goalparser('(al)(al)G()()') == 'alalGoo') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
