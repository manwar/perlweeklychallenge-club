#! /usr/bin/node

"use strict"

function recomposemac(inp) {
    let out = "";
    let count = 0;
    for (let c of inp) {
        if ((c >= '0' && c <= '9') || (c >= 'a' && c <= 'f')) {
            if (count == 2) {
                out += ":";
                count = 0;
            }
            count++;
            out += c;
        }
    }
    return out;
}

if (recomposemac("1ac2.34f0.b1c2") == "1a:c2:34:f0:b1:c2") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (recomposemac("abc1.20f1.345a") == "ab:c1:20:f1:34:5a") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
