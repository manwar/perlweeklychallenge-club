#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util 'sum';

sub _get_permutations {
    # A little recursive function to generate all permutations of the
    #  sets of numbers.
    my ( $remaining, $used ) = @_;
    my @permutations = ();

    if ( $#$remaining == 0 ) {
        # We have a new permutation
        return [ @$used, @$remaining ];
    }

    for my $i ( 0 .. $#$remaining ) {
        # Use one of the remaining numbers (in the order of the array),
        #  any recursively call this function
        my @new_used      = ( @$used, $remaining->[$i] );
        my @new_remaining = @$remaining;
        splice( @new_remaining, $i, 1 );
        push @permutations, _get_permutations( \@new_remaining, \@new_used );
    }

    return @permutations;

}

sub main {
    my @numbers = @_;

    # Sanity check
    die "You must specify seven numbers\n" unless scalar(@numbers) == 7;
    foreach (@numbers) {
        die "$_ is not a number\n" unless /^\d+(?:\.\d+)?/;
    }

    # Define the values in each box
    my @boxes = ( [ 0, 1 ], [ 1, 2, 3 ], [ 3, 4, 5 ], [ 5, 6 ] );

    # Generate all permatations. There is only 5,040 of them
    my @permutations = _get_permutations( [@numbers], [] );

  P: foreach my $permutation (@permutations) {
        # Calculate the sums for each box in this permutation
        my @sums = ();
        foreach my $box (@boxes) {
            push @sums, sum( @$permutation[@$box] );

            # This permutation is not the correct one
            next P if $sums[-1] != $sums[0];
        }

        # We have a solution! Print the results and exit
        my $letter = 'a';
        foreach my $n (@$permutation) {
            say "$letter = $n";
            ++$letter;
        }

        return;
    }

    say 'No solution found!';
}

main(@ARGV);
