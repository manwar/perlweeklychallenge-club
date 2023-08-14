#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(min max);
use Test::More;

sub most_frequent_even {
    my (@list) = @_;

    my %frequency;

    # Count the frequency of even numbers
    for my $num (@list) {
        $frequency{$num}++ if $num % 2 == 0;
    }

    # If no even numbers found
    return -1 unless keys %frequency;

    # Find the even number with the highest frequency
    my $max_freq   = max values %frequency;
    my @candidates = grep { $frequency{$_} == $max_freq } keys %frequency;

    return min @candidates;
}

# Test Cases
is( most_frequent_even( 1, 1, 2, 6, 2 ), 2,  'Most frequent even number' );
is( most_frequent_even( 1, 3, 5, 7 ),    -1, 'No even number' );
is( most_frequent_even( 6, 4, 4, 6, 1 ), 4,  'Multiple most frequent even numbers' );

done_testing();
