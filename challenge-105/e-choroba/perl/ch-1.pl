#!/usr/bin/perl
use warnings;
use strict;

=head1 Nth root

The real challenge here was to get the formatting of the result right.
34 ** (1/5) is in fact 2.02439745849989, which we can format with
sprintf '%.2f', but that would turn 12 in the first test into 12.00.
Adding it to zero fixes the issue.

=cut

sub nth_root {
    my ($n, $k) = @_;
    return 0 + sprintf '%.2f', $k ** (1 / $n)
}

use Test::More tests => 2;

is nth_root(5, 248832), 12;
is nth_root(5,     34),  2.02;
