#!/usr/bin/env perl

# See https://en.wikipedia.org/wiki/Pascal%27s_triangle#Calculating_a_row_or_diagonal_by_itself
# See https://www.mathsisfun.com/pascals-triangle.html

use 5.010;
use strict;
use warnings;
use utf8;

sub generate_pascal_row {
    my $n = shift;

    my @rows = (1);
    foreach my $k (0..$n - 1) {
        push @rows, $rows[$k] * ($n - $k) / ($k + 1);
    }
    return \@rows;
}

my $n = $ARGV[0] || die "Expect number of row";
say "$_: @{generate_pascal_row($_)}" for (0..$n);

1;
# vi:et:sw=4 ts=4 ft=perl

__END__
$ perl ch2.pl 8
0: 1
1: 1 1
2: 1 2 1
3: 1 3 3 1
4: 1 4 6 4 1
5: 1 5 10 10 5 1
6: 1 6 15 20 15 6 1
7: 1 7 21 35 35 21 7 1
8: 1 8 28 56 70 56 28 8 1
