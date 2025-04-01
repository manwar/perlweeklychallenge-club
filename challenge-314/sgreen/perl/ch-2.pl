#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@strs) {
    # Check all strings are of the same length
    foreach my $str (@strs) {
        if ( length($str) != length( $strs[0] ) ) {
            die "Strings are not of the same length\n";
        }
    }

    my $unsorted_count = 0;

  O: for my $idx ( 0 .. length( $strs[0] ) - 1 ) {
        # Check that the characters at position idx are sorted
        my @characters = map { substr( $_, $idx, 1 ) } @strs;

        foreach my $sub_idx ( 1 .. $#characters ) {
            if ( $characters[ $sub_idx - 1 ] gt $characters[$sub_idx] ) {
                # If the character at this position is less than the last one
                #  it is not sorted
                $unsorted_count++;
                next O;
            }
        }
    }

    # Return the counted of unsorted columns
    say $unsorted_count;
}

main(@ARGV);
