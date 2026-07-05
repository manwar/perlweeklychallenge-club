#! /usr/bin/node

"use strict"

function counterify(a) {
    let cc = new Map;
    for (let x of a) {
        if (!cc.has(x)) {
            cc.set(x, 0);
        }
        cc.set(x, cc.get(x) + 1);
    }
    return cc;
}

function sumoffrequencies(a) {
    let vw = 0;
    let cn = 0;
    let cc = counterify(a.split(""));
    let cv = Array.of(...cc.values());
    cv.sort();
    cv.reverse();
    for (let n of cv) {
        for (let [c, ni] of cc) {
            if (ni == n) {
                switch (c) {
                case "a":
                case "e":
                case "i":
                case "o":
                case "u":
                    if (vw == 0) {
                        vw = n;
                    }
                    break;
                default:
                    if (cn == 0) {
                        cn = n;
                    }
                }
            }
            if (vw > 0 && cn > 0) {
                break;
            }
        }
        if (vw > 0 && cn > 0) {
            break;
        }
    }
    return vw + cn;
}

if (sumoffrequencies('banana') == 5) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sumoffrequencies('teestett') == 7) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sumoffrequencies('aeiouuaa') == 3) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sumoffrequencies('rhythm') == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sumoffrequencies('x') == 1) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
