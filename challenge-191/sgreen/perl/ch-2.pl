#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'none';

sub find_solutions ( $front, $back ) {
    # Recursive function to find possible solutions. Front is the numbers we
    #  have processed, back is what remains
    if ( scalar(@$back) == 0 ) {
        return 1;
    }

    # Iterate over the next value
    my $count = 0;

    foreach my $i ( @{ $back->[0] } ) {
        # Call the recursive function if we haven't used this number already
        if ( none { $_ == $i } @$front ) {
            $count +=
              find_solutions( [ @$front, $i ], [ @{$back}[ 1 .. $#$back ] ] );
        }
    }

    # Return the number of matches up the recursive function
    return $count;
}

sub main ($n) {
    # Generate a list of list with a possible value for each number
    my @possible = ();

    foreach my $i ( 1 .. $n ) {
        push @possible, [ grep { $_ % $i == 0 or $i % $_ == 0 } ( 1 .. $n ) ];
    }

    say find_solutions( [], \@possible );
}

main( $ARGV[0] )
