#!/usr/bin/env perl

use strict;
use warnings;
use feature qw<say>;

use List::Util qw<sum>;
use Scalar::Util qw<looks_like_number>;

if ( @ARGV < 2 || grep { !looks_like_number($_) || $_ < 1 } @ARGV ) {
    say 'List of at least 2 positive numbers required.';
    exit 1;
}

my @combinations;
my @idxs = (0);

TOP: while (1) {

    # Add a combination to our array if the sum of that combination
    # is ≤ half the sum of args i.e. we can make them all negative
    push @combinations, [ @ARGV[@idxs] ]
        if sum( @ARGV[@idxs] ) <= sum(@ARGV) / 2;

    # Nothing left to do if all indexes are covered
    last if @idxs == @ARGV;

    # Increase last index if possible
    if ( $idxs[-1] < $#ARGV ) {
        $idxs[-1]++;
    }

    # If we've maxed out the last index
    else {
        # Loop through all the previous indexes
        for ( my $i = $#idxs; $i > 0; $i-- ) {

            # If the difference between an index
            # and the one before is more than 1
            if ( $idxs[$i] - $idxs[ $i - 1 ] > 1 ) {

                # Increase that previous index
                my $j = ++$idxs[ $i - 1 ];

                # Reset all the subsequent indexes (+1 of previous index)
                for ( @idxs[ $i .. $#idxs ] ) {
                    $_ = ++$j;
                }

                # Go back to the start
                next TOP;
            }
        }

        # Reset all indexes and add an additional element
        # if we couldn't increase any further
        @idxs = ( 0 .. @idxs );
    }
}

say scalar(
    @{  (   sort { sum( @{$b} ) <=> sum( @{$a} ) || @{$a} <=> @{$b} }
                @combinations
        )[0]
    }
);
