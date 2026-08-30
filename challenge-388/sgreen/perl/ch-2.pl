#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use Algorithm::Combinatorics 'permutations';
use List::Util 'none';

sub main ($people) {
    # Count the number of valid permutations
    my $count  = 0;
    my @people = ( 0 .. $people - 1 );

    # Go through each permutation
    my $permutations = permutations( \@people );
    while ( my $p = $permutations->next() ) {
        # Only count it if they aren't giving a gift to themselves
        if ( none { $p->[$_] eq $_ } ( 0 .. $people - 1 ) ) {
            $count++;
        }
    }

    say $count;
}

main(@ARGV);
