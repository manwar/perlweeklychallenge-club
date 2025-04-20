#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@array) {
    # The last value is the string we are comparing
    my $word = pop(@array);

    # Make up the acronym for the first letter in each word
    my $acronym = join( '', map { substr( $_, 0, 1 ) } @array );

    # Compare it to the supplied string
    say lc($acronym) eq lc($word) ? 'true' : 'false';
}

main(@ARGV);