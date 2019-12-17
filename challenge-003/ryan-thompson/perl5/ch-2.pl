#!/usr/bin/env perl
#
# ch-2.pl - Pascal's Triangle
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

my $height = shift // die "Usage: $0 <height>";

say "@{$_}" for pascal_triangle($height);

# Generate Pascal's Triangle to the specified height.
# Note we do not pretty-print it like I did in the p6 solution, as I wanted to
# demonstrate a more generic solution.
sub pascal_triangle {
    my $h = shift;

    my @tri = [1];
    push @tri, [ 1, map { $tri[-1][$_-1] + $tri[-1][$_] } 1..$_ ] for 1..$h-1;

    @tri;
}
