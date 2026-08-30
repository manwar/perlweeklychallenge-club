#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub dyck_words( $n, $dyck ) {
    if ( not defined $dyck ) {
        # First call. The first move is always 'U' (Up)
        $dyck = "U";
    }

    if ( length($dyck) == 2 * $n ) {
        # We have a solution if the length of the string is 2 × n.
        return ($dyck);
    }

    # Count how many more ups than downs in the string so far
    my $steps = ( $dyck =~ tr/U/U/ ) - ( $dyck =~ tr/D/D/ );

    # All solutions from calling the recursive function
    my @solutions = ();

    if ( $steps > 0 ) {
        # We're not at the bottom and can move down
        my @down = dyck_words( $n, "${dyck}D" );
        if ( $#down != -1 ) {
            push @solutions, @down;
        }
    }
    if ( $steps < 2 * $n - length($dyck) ) {
        # We can move up only if there are enough downs to match
        my @up = dyck_words( $n, "${dyck}U" );
        if ( $#up != -1 ) {
            push @solutions, @up;
        }
    }

    return @solutions;
}

sub main ($n) {
    my @solutions = dyck_words( $n, undef );

    # Print the list alphabetically.
    say "(" . join( ", ", map { qq{"$_"} } sort @solutions ) . ")";
}

main(@ARGV);
