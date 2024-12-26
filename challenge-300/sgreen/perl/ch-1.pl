#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics 'permutations';

sub main ($int) {
    my $count = 0;

    # Calculate all permutations
    my $iter = permutations( [ 1 .. $int ] );
  P: while ( my $p = $iter->next ) {
        foreach my $i ( 0 .. $int - 1 ) {
            if ( ($p->[$i] % ( $i + 1 ) != 0 )and (( $i + 1 ) % $p->[$i] != 0) ) {
                next P;
            }
        }

        # We have a beautiful arrangement, add to the counter.
        ++$count;
    }

    say $count;
}

main( $ARGV[0] );