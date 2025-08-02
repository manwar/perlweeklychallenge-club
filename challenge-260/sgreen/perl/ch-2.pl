#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Math::Combinatorics;

sub main ($word) {
    # Convert to lower case, and sort the letters alphabetically
    my @letters = sort ( split //, lc($word) );
    my $count   = 0;

    # Go through each sorted unique permutation and count where <= $word
    my $c = Math::Combinatorics->new(
        data      => \@letters,
        frequency => [ (1) x length($word) ]
    );

    while ( my @perm = $c->next_string() ) {
        if ( join( '', @perm ) le $word ) {
            $count++;
        }
    }

    # Return the rank
    say $count;
}

main(@ARGV);