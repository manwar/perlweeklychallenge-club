#!/usr/bin/env perl

use Modern::Perl;

# Task #2
# Formatted Multiplication Table
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

my $N = 11;

my $table;

for my $n ( 1 .. $N ) {
    for my $m ( $n .. $N ) {
        $table->[$n][$m] = $n * $m;
    }
}

say sprintf "%3s|%s", 'x', join '', map { sprintf "%4d", $_ } 1 .. $N;
say '---|' . '-' x ( $N * 4 );
for my $n ( 1 .. $N ) {
    say sprintf "%3d|%s", $n, join '', map { my $v = $table->[$n][$_]; defined $v ? ( sprintf "%4d", $v ) : ' ' x 4 } 1 .. $N;
}
