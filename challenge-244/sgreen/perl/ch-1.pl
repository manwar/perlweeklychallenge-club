#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub less_than ( $i, $ints ) {
    # Return the number of items in the array less than $i
    return scalar( grep { $_ < $i } @$ints );
}

sub main (@ints) {
    my @solution = map { less_than( $_, \@ints ) } @ints;
    say join ', ', @solution;
}

main(@ARGV);