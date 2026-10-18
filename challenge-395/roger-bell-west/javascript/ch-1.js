#! /usr/bin/node

"use strict"

function parsecomplex(a) {
    const re = new RegExp("^\\(?([-0-9]+)\\)?\\+\\(?([-0-9]+)\\)?i$");
    const mr = a.match(re);
    if (mr !== null) {
        return [mr[1], mr[2]];
    } else {
        return [0, 0];
    }
}

function complexnumber(aa, bb) {
    const ab = parsecomplex(aa);
    const a = ab[0];
    const b = ab[1];
    const cd = parsecomplex(bb);
    const c = cd[0];
    const d = cd[1];
    const ca = a * c - b * d;
    const cb = a * d + b * c;
    if (cb >= 0) {
        return ca.toString() + "+" + cb.toString() + "i"
    } else {
        return ca.toString() + "+(" + cb.toString() + ")i"
    }
}

if (complexnumber('1+1i', '1+1i') == '0+2i') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (complexnumber('1+(-1)i', '1+(-1)i') == '0+(-2)i') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (complexnumber('0+3i', '0+4i') == '-12+0i') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (complexnumber('3+4i', '3+(-4)i') == '25+0i') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (complexnumber('50+-20i', '-10+30i') == '100+1700i') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
