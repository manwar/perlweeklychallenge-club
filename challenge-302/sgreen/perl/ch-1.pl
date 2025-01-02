#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics 'combinations';

sub main (@str) {
    # The last two values are max_zeros, and max_ones
    my $max_ones  = pop(@str);
    my $max_zeros = pop(@str);

    # Consider all lengths of subsets, largest first
    for ( my $length = scalar(@str) ; $length > 0 ; $length-- ) {
        # Compute all subsets of this length
        my $iter = combinations( \@str, $length );
        while ( my $subset = $iter->next ) {
            # Combine the strings to a single string
            my $bits       = join( '', @$subset );
            my $count_zero = ( $bits =~ tr/0/0/ );
            my $count_one  = ( $bits =~ tr/1/1/ );
            if ( $count_zero <= $max_zeros and $count_one <= $max_ones ) {
                # We have found the largest subset
                say $length;
                return;
            }
        }
    }

    # Nothing matches
    say 0;
}

main(@ARGV);