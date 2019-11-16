#!/usr/bin/perl
# Write a script to print 11x11 multiplication table, only the top half triangle.

#   x|   1   2   3   4   5   6   7   8   9  10  11
# ---+--------------------------------------------
#   1|   1   2   3   4   5   6   7   8   9  10  11
#   2|       4   6   8  10  12  14  16  18  20  22
#   3|           9  12  15  18  21  24  27  30  33
#   4|              16  20  24  28  32  36  40  44
#   5|                  25  30  35  40  45  50  55
#   6|                      36  42  48  54  60  66
#   7|                          49  56  63  70  77
#   8|                              64  72  80  88
#   9|                                  81  90  99
#  10|                                     100 110
#  11|                                         121
use strict;
use warnings;
use feature 'say';

my $n = $ARGV[0] || 11;
printf "  x|";
printf (" %3d",$_) for 1..$n;
print "\n---+".("-" x (4*$n))."\n";
for my $x (1..$n) {
    printf("%3d|", $x);
    for my $y (1..$n) {
        if ($x*$y < $x**2) {
            print "    ";
        } else {
            printf (" %3d", $x*$y);
        }
    }
    say "";
}
 
