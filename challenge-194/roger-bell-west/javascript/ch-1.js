#! /usr/bin/node

"use strict"

function digitalclock(hhmm) {
    let i = hhmm.indexOf("?");
    if (i == 0) {
        if (hhmm.charAt(1) <= "3") {
            return 2;
        }
        return 1;
    } else if (i == 1) {
        if (hhmm.charAt(0) < "2") {
            return 9;
        }
        return 3;
    } else if (i == 3) {
        return 5;
    } else if (i == 4) {
        return 9;
    }
    return 0;
}

if (digitalclock("?5:00") == 1) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (digitalclock("?3:00") == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (digitalclock("1?:00") == 9) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (digitalclock("2?:00") == 3) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (digitalclock("12:?5") == 5) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (digitalclock("12:5?") == 9) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
