#! /usr/bin/node

"use strict"

function rearrangespaces(a) {
    let words = [];
    let spaces = 0;
    let ww = "";
    for (let c of a.split("")) {
        if (c == " ") {
            spaces += 1;
            if (ww != "") {
                words.push(ww);
                ww = "";
            }
        } else {
            ww += c;
        }
    }
    if (ww != "") {
        words.push(ww);
    }
    let spdiv = 0;
    let remainder = spaces;
    let divs = words.length - 1;
    if (divs > 0) {
        spdiv = Math.floor(spaces / divs);
        remainder = spaces % divs;
    }
    let out = words.join(" ".repeat(spdiv));
    if (remainder > 0) {
        out += " ".repeat(remainder);
    }
    return out;
}

if (rearrangespaces('  challenge  ') == 'challenge    ') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (rearrangespaces('coding  is  fun') == 'coding  is  fun') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (rearrangespaces('a b c  d') == 'a b c d ') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (rearrangespaces('  team      pwc  ') == 'team          pwc') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (rearrangespaces('   the  weekly  challenge  ') == 'the    weekly    challenge ') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
