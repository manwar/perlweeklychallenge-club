#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@list) {
    my $gap   = 0;    # The maximum gap
    my $count = 0;    # Number of occurrences

    # Sort the list
    @list = sort { $a <=> $b } @list;

    # Iterate through the list
    foreach my $i ( 0 .. $#list - 1 ) {
        my $diff = $list[ $i + 1 ] - $list[$i];
        if ( $diff > $gap ) {
            # We have a new maximum, reset the count
            $gap   = $diff;
            $count = 1;
        }
        elsif ( $diff == $gap ) {
            # Add to the count
            $count++;
        }
    }

    # Display the result
    say $count;
}

main(@ARGV);