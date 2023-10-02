#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ sum };

my @examples = ( [ 10, 4, 8, 3 ], [1], [ 1, 2, 3, 4, 5 ], );

for my $e (@examples) {
    my @example = $e->@*;
    my @output  = left_right_sum_diff(@example);
    my $output  = join ', ', @output;
    my $input   = join ', ', $e->@*;
    say <<~"END";
    Input:  \@ints = ($input)
    Output: ($output)
    END
}

sub left_right_sum_diff( @ints ) {
    my @left_ints  = ( 0, @ints );
    my @right_ints = ( @ints, 0 );
    my @out;

    my $top = -1 + scalar @left_ints;
    for my $i ( 0 .. -1 + scalar @ints ) {
        my $k     = 1 + $i;
        my $left  = sum( @left_ints[ 0 .. $i ] );
        my $right = sum( map { $right_ints[$_] } $k .. $top );
        push @out, abs( $left - $right );
    }
    return @out;
}
