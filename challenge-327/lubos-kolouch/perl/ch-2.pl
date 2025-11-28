#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

MAD (Weekly Challenge 327)

Given distinct integers, find all pairs with the minimum absolute
difference between any two elements. Return pairs sorted by value.

=cut

sub mad_pairs (@ints) {
    return [] if @ints < 2;
    my @sorted = sort { $a <=> $b } @ints;
    my $min = 'inf';
    my @pairs;
    for my $i (1 .. $#sorted) {
        my $diff = $sorted[$i] - $sorted[$i - 1];
        if ($diff < $min) {
            $min   = $diff;
            @pairs = ([ $sorted[$i - 1], $sorted[$i] ]);
        }
        elsif ($diff == $min) {
            push @pairs, [ $sorted[$i - 1], $sorted[$i] ];
        }
    }
    return \@pairs;
}

if (!caller) {
    require Test::More;
    Test::More::is_deeply( mad_pairs(4, 1, 2, 3), [ [1,2], [2,3], [3,4] ], 'Example 1' );
    Test::More::is_deeply( mad_pairs(1, 3, 7, 11, 15), [ [1,3] ], 'Example 2' );
    Test::More::is_deeply( mad_pairs(1, 5, 3, 8), [ [1,3], [3,5] ], 'Example 3' );
    Test::More::done_testing();
}
