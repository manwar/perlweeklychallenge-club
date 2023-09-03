#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(min max);

sub main (@ints) {
    # Determine the minimum and maximum values
    my $min_int = min(@ints);
    my $max_int = max(@ints);

    # Calculate list of values that are not minimum or maximum
    my @solution = grep { $_ != $min_int and $_ != $max_int } @ints;

    if ( scalar(@solution) ) {
        say '(', join( ', ', @solution ), ')';
    }
    else {
        say -1;
    }
}

main(@ARGV);