#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics qw(permutations);
use List::Util               qw(any);

sub main (@ints) {
    my @solution = ();

    my $iter = permutations( \@ints );
  P: while ( my $p = $iter->next ) {
        # Have we seen this solution before
        my $string = '(' . join( ', ', @$p ) . ')';
        next if any { $_ eq $string } @solution;

        # Is each pair a square of an integer
        foreach my $i ( 1 .. $#ints ) {
            my $sqrt = sqrt( $p->[ $i - 1 ] + $p->[$i] );
            if ( $sqrt != int($sqrt) ) {
                next P;
            }
        }

        # It is. Add a formatted version of these items to the solution array.
        push @solution, $string;
    }

    say join( ', ', @solution );

}

main(@ARGV);
