#!/usr/bin/perl
use warnings;
use strict;

sub interleave_string {
    my ($x, $y, $z) = @_;
    return 0 if length($z) != length($x) + length($y);

    return 1 if "" eq $z;

    my ($first_x, $first_y, $first_z) = map { substr $_, 0, 1 } $x, $y, $z;

    my $maybe_x = $first_x eq $first_z;
    my $maybe_y = $first_y eq $first_z;

    my $rest_x = $maybe_x ? substr $x, 1 : "";
    my $rest_y = $maybe_y ? substr $y, 1 : "";
    my $rest_z = substr $z, 1;

    if ($maybe_x && $maybe_y) {
        return interleave_string($rest_x, $y, $rest_z)
            || interleave_string($x, $rest_y, $rest_z)
    }

    return interleave_string($rest_x, $y, $rest_z) if $maybe_x;

    return interleave_string($x, $rest_y, $rest_z) if $maybe_y;

    return 0
}

use Test::More;

is interleave_string('XY', 'X', 'XXY'), 1, 'Example 1';
is interleave_string('XXY', 'XXZ', 'XXXXZY'), 1, 'Example 2';
is interleave_string('YX', 'X', 'XXY'), 0, 'Example 3';

is interleave_string('ABC', 'BD', $_), 1, $_
    for qw( ABDBC ABCBD ABBCD ABBDC BABCD BABDC BADBC BDABC );


done_testing();
