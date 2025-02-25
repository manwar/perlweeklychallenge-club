#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(any sum);

sub main (@binary) {
    # Check that we have only zeros and ones
    if ( any { $_ != 0 and $_ != 1 } @binary ) {
        die "Only zeros and ones are allowed!\n";
    }

    # The maximum length is the largest even number <= length of the array
    my $max_length = scalar(@binary);
    if ( $max_length % 2 ) {
        $max_length--;
    }

    # Try the longest length first
    for ( my $length = $max_length ; $length > 0 ; $length -= 2 ) {
        # Check if any string matches the criteria
        foreach my $start ( 0 .. scalar(@binary) - $length ) {
            # The criteria is met if the sum of the 1s and 0s is half the length
            if ( sum( @binary[ $start .. $start + $length - 1 ] ) ==
                $length / 2 )
            {
                say $length;
                return;
            }
        }
    }

    say 0;
}

main(@ARGV);