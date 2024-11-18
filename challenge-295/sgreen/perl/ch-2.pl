#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub jump_game( $ints, $moves ) {
    # Calculate the minimum number of moves from this point
    my $min_moves = undef;

    for ( my $i = $ints->[0] ; $i > 0 ; $i-- ) {
        # We can complete the jump with this move
        if ( $i >= $#$ints ) {
            return $moves;
        }

        # Skip if we can't move forward
        if ( $ints->[$i] == 0 ) {
            next;
        }

        # Call the function again jumping 'i' positions
        my $m = jump_game( [ $ints->[ $i .. $#$ints ] ], $moves + 1 );
        if ( defined($m) and ( not defined($min_moves) or $min_moves > $m ) ) {
            $min_moves = $m;
        }
    }

    return $min_moves;
}

sub main (@ints) {
    my $moves = jump_game( \@ints, 1 );
    say $moves // -1;
}

main(@ARGV);