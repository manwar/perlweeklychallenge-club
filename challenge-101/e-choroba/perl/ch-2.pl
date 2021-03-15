#!/usr/bin/perl
use warnings;
use strict;

use constant THRESHOLD => 1e-10;

sub area {
    my ($A, $B, $C) = @_;
    return abs((  $B->[0] - $A->[0]) * ($C->[1] - $A->[1])
               - ($C->[0] - $A->[0]) * ($B->[1] - $A->[1])) / 2
}

my $Z = [0, 0];
sub origin_containing_trianlge {
    my ($A, $B, $C) = @_;

    my $whole = area($A, $B, $C);
    my ($a1) = area($A, $B, $Z);
    my ($a2) = area($B, $C, $Z);
    my ($a3) = area($A, $C, $Z);
    my $sum = $a1 + $a2 + $a3;

    return abs($sum - $whole) < THRESHOLD ? 1 : 0
}

use Test::More;
is origin_containing_trianlge([0, 1], [1, 0], [2, 2]), 0, 'Example 1';
is origin_containing_trianlge([1, 1], [-1, 1], [0, -3]), 1, 'Example 2';
is origin_containing_trianlge([0, 1], [2, 0], [-6, 0]), 1, 'Example 3';

is origin_containing_trianlge([1, 1], [3, 7], [0, 0]), 1, 'Vertex at 0, 0';
is origin_containing_trianlge([-2, -1], [0, 4], [5, 3]), 0, 'outside';
is origin_containing_trianlge([-2, -1], [0, 4], [5, 2]), 1, 'inside';
is origin_containing_trianlge([12, 3], [-10, -10], [6, 6]), 1, 'borderline';
is origin_containing_trianlge([-10, -10], [5.999, 6], [12, 3]), 1, 'closely in';
is origin_containing_trianlge([-10, -10], [6.001, 6], [12, 3]), 0, 'closely out';

done_testing();
