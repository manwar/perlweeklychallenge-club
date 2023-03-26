#!/usr/bin/perl

use v5.16;
use warnings;

main: {
    my @num = 1 .. 11;
    my $fmt = "%4.0d" x @num;
    printf "  x|$fmt\n", @num;
    print  "---+" . "-" x (4 * @num) . "\n";
    for my $x (@num) {
        printf "%3d|$fmt\n", $x, map +($_ >= $x) * $_ * $x, @num;
    }
}
