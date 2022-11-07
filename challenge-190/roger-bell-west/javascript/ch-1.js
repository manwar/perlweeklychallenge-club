#! /usr/bin/node

"use strict"

function capitaldetection(s) {
    if (s.match(/^([A-Z]+|[a-z]+|[A-Z][a-z]+)$/)) {
        return true;
    } else {
        return false;
    }
}

if (capitaldetection("Perl")) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (capitaldetection("TPF")) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (!capitaldetection("PyThon")) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (capitaldetection("raku")) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
