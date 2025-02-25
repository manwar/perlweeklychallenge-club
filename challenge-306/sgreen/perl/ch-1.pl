#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'sum';

sub main (@ints) {
    my $solution = 0;

    my $l = scalar(@ints);

    # The odd-length length of sub array
    for ( my $length = 1 ; $length <= $l ; $length += 2 ) {
        # The starting position of this sub array
        foreach my $start ( 0 .. $l - $length ) {
            $solution += sum( @ints[ $start .. $start + $length - 1 ] );
        }
    }

    say $solution;
}

main(@ARGV);
