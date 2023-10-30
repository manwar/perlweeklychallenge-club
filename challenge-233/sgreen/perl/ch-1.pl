#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'uniq';

sub main (@words) {
    # Calculate the occurrences of sorted unique strings
    my %freq = ();
    foreach my $w (@words) {
        my $s = join( '', sort( uniq( split //, lc($w) ) ) );
        ++$freq{$s};
    }

    # Now find out how many pairs of similar words there are for each dict key
    my $solution = 0;
    foreach my $v ( values(%freq) ) {
        if ( $v > 1 ) {
            $solution += $v * ( $v - 1 ) / 2;
        }
    }

    # Display the answer
    say $solution;
}

main(@ARGV);