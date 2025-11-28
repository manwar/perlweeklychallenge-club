#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

2D Array (Weekly Challenge 324)

Given a flat array and dimensions r x c, reshape into a 2D array filled
row-wise. Assumes enough elements (length == r*c).

=cut

sub make_2d_array ($r, $c, @ints) {
    my @rows;
    for my $i (0 .. $r - 1) {
        my $start = $i * $c;
        push @rows, [ @ints[ $start .. $start + $c - 1 ] ];
    }
    return \@rows;
}

if (!caller) {
    require Test::More;
    Test::More::is_deeply( make_2d_array(2, 2, 1, 2, 3, 4), [ [1,2], [3,4] ], 'Example 1' );
    Test::More::is_deeply( make_2d_array(1, 3, 1, 2, 3), [ [1,2,3] ], 'Example 2' );
    Test::More::is_deeply( make_2d_array(4, 1, 1, 2, 3, 4), [ [1], [2], [3], [4] ], 'Example 3' );
    Test::More::done_testing();
}
