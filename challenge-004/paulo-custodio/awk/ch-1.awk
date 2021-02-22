#!/usr/bin/gawk

# Challenge 004
#
# Challenge #1
# Write a script to output the same number of PI digits as the size of your script.
# Say, if your script size is 10, it should print 3.141592653.
#
# we need a big-math library to compute any large number of digits

BEGIN {
    size = ARGV[1] ? ARGV[1] : 1000;
    bc = "echo 'scale=" (size+10) "; 4*a(1)' | bc -l";
    pi = "";
    while ((bc | getline temp) > 0) {
        gsub(/\\/, "", temp);
        pi = pi temp;
    }
    pi = substr(pi, 1, size+1)
    print pi;
    exit 0;
}
