# Create a script that generates Pascal Triangle. Accept number of
# rows from the command line. The Pascal Triangle should have at least
# 3 rows.

use v5.10;
use strict;
use warnings;

my $rows = shift;
die "usage: $0 <rows, 3 or higher>\n" unless $rows and $rows >= 3;

my $previous = [];
for (1..$rows) {
    my $next = [];
    $next->[0] = 1; # first number in row is always 1

    # when previous row is at least two long (last index is > 1), start adding sums to new row
    for my $i (1..$#$previous) {
        $next->[$i] = $previous->[$i-1] + $previous->[$i];
    }
    $next->[@$previous] = 1; # and last number is always 1 (index = the length of previous row)
    $previous = $next;
    say "@$next";
}
