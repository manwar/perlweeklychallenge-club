#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'any';

sub main (@ints) {
    my $start    = pop(@ints);
    my $solution = $start;

    while ( any { $solution == $_ } @ints ) {
        $solution *= 2;
    }

    say $solution;
}

main(@ARGV);