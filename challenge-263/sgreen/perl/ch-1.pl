#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # The last value is $k
    my $k = pop(@ints);

    # Sort the rest of the array
    @ints = sort { $a <=> $b } @ints;

    # Return the indexes where the item is 'k'
    my @result = grep { $ints[$_] == $k } ( 0 .. $#ints );

    say '(', join( ', ', @result ), ')';
}

main(@ARGV);