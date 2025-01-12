#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics 'variations';

sub main (@ints) {
    # Hashes store unique numbers
    my %solution = ();

    # Work through all the digit permutations
    my $iter = variations( \@ints, 3 );
    while ( my $p = $iter->next() ) {

        # Ignore odd numbers (last digit), or if the first digit is zero
        if ( $p->[-1] % 2 == 1 or $p->[0] == 0 ) {
            next;
        }

        # Combine the numbers and add it to the set
        my $number = join( '', @$p );
        $solution{$number} = 1;
    }

    my @sorted = sort { $a <=> $b } keys %solution;
    say '(', join( ', ', @sorted ), ')';
}

main(@ARGV);