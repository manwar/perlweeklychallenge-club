#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub smaller_ints ( $ints, $target ) {
    # Count the number of integers that are less than the target
    return scalar( grep { $_ < $target } @$ints );
}

sub main (@ints) {
    my @results = map { smaller_ints( \@ints, $_ ) } @ints;
    say '(', join( ', ', @results ), ')';
}

main(@ARGV);