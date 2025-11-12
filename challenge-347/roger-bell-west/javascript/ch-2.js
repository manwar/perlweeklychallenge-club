#! /usr/bin/node

"use strict"

function formatphonenumber(a) {
    let pure = [];
    for (let c of a.split('')) {
        if (c >= '0' && c <= '9') {
            pure.push(c);
        }
    }
    let left = pure.length;
    let out = [];
    let i = 0;
    if (left > 4) {
        for (let c of pure) {
            out.push(c);
            i += 1;
            left -= 1;
            if (i % 3 == 0) {
                out.push('-');
                if (left <= 4) {
                    break;
                }
            }
        }
    }
    if (left == 4) {
        out.push(pure[i]);
        out.push(pure[i + 1]);
        out.push('-');
        i += 2;
    }
    for (let p = i; p < pure.length; p++) {
        out.push(pure[p]);
    }
    return out.join("");
}

if (formatphonenumber('1-23-45-6') == '123-456') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (formatphonenumber('1234') == '12-34') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (formatphonenumber('12 345-6789') == '123-456-789') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (formatphonenumber('123 4567') == '123-45-67') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (formatphonenumber('123 456-78') == '123-456-78') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
