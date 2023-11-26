#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics 'combinations';
use List::Util qw(min max);

sub calculate_power($numbers) {
    # Return the square of the maximum number multiplied by the smallest one
    my $min_int = min(@$numbers);
    my $max_int = max(@$numbers);
    return $max_int ** 2 * $min_int;
}

sub main (@ints) {
    my $power = 0;
    foreach my $len ( 1 .. $#ints + 1 ) {
        my $iter = combinations( \@ints, $len );
        while ( my $c = $iter->next ) {
            $power += calculate_power($c);
        }
    }

    say $power;
}

main(@ARGV);