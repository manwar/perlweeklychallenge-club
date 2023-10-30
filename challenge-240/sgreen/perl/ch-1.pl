#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@words) {
    # The last value is the acronym
    my $acronym = pop(@words);

    # Calculate the first letters from the words
    my $first_letters = join( '', map { substr( $_, 0, 1 ) } @words );
    say lc($first_letters) eq lc($acronym) ? 'true' : 'false';
}

main(@ARGV);