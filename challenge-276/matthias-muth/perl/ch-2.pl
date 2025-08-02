#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 276 Task 2: Maximum Frequency
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( max );

sub maximum_frequency( @ints ) {
    my %freq;
    ++$freq{$_}
        for @ints;
    my $max_freq = max( values %freq );
    return scalar grep $freq{$_} == $max_freq, @ints;
}

use Test2::V0 qw( -no_srand );
is maximum_frequency( 1, 2, 2, 4, 1, 5 ), 4,
    'Example 1: maximum_frequency( 1, 2, 2, 4, 1, 5 ) == 4';
is maximum_frequency( 1, 2, 3, 4, 5 ), 5,
    'Example 2: maximum_frequency( 1, 2, 3, 4, 5 ) == 5';
done_testing;
