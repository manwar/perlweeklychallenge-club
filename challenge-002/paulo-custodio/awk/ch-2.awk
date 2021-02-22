#!/usr/bin/gawk

# Challenge 002
#
# Challenge #2
# Write a script that can convert integers to and from a base35
# representation, using the characters 0-9 and A-Y. Dave Jacoby came up
# with nice description about base35, in case you needed some background.

function format_number(n, base,    negative, output, d) {
    if (n < 0) {
        negative = 1;
        n = -n
    }
    else {
        negative = 0;
    }

    output = ""
    do {
        d = n % base;
        n = int(n / base);
        output = substr(digits, d+1, 1) output;
    } while (n > 0)

    if (negative)
        output = "-" output;

    return output;
}

function scan_number(str, base,    n, negative, ch, d) {
    n = 0;
    if (sub(/^-/, "", str))
        negative = 1;
    else
        negative = 0;

    while (str != "") {
        ch = toupper(substr(str, 1, 1));
        str = substr(str, 2);
        d = index(digits, ch) - 1;
        if (d < 0 || d >= base) {
            print "cannot parse '" str "'";
            exit(1);
        }
        n = base * n + d;
    }
    if (negative)
        n = -n;
    return n;
}

BEGIN {
    BASE = 35;
    digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    if (ARGV[1] == "-r")
        print scan_number(ARGV[2], 35);
    else
        print format_number(ARGV[1], 35);
    exit 0
}
