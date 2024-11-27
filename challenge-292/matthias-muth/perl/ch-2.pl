#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 292 Task 2: Zuma Game
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Verbose;
# $verbose = 1;

use List::Util qw( uniq );

sub zuma_game( $board, $hand ) {

    # Initialize the queue with the initial situation.
    my @queue = ( [ $board, $hand, 0 ] );
    my $n_tries = 0;

    # Traverse the graph.
    while ( @queue ) {
        my ( $board, $hand, $n_moves ) = @{ shift @queue };
        my $indent = " " x ( $n_moves * 2 );
        vsay $indent, "$board $hand";

        # Go through the colors of the existing balls
        # (do not repeat the same color).
        for my $insertion ( uniq split "", $hand ) {
	    vsay $indent, "  trying $insertion";

            # Remove *one* ball of the insertion color from the hand.
            my $reduced_hand = $hand =~ s/$insertion//r;

            # Try all positions for that ball.
            for ( 0..length( $board ) ) {

                # Insert the ball at that position.
                ++$n_tries;
                substr( my $new_board = $board, $_, 0 ) = $insertion;
		vsay $indent, "    $new_board $reduced_hand";

                # Do as many removals as possible.
		while ( $new_board =~ s/(.)\g{-1}{2,}// ) {
                    # Everything is in the loop condition.
                }

                # Check end criteria.
                if ( $new_board eq "" ) {
                    say "n_tries: $n_tries";
                    return $n_moves + 1;
                }

                # Descend further (if needed and possible).
                if ( $reduced_hand ne "" ) {
                    vsay $indent, "    pushing [ $new_board, $reduced_hand, ",
                        $n_moves + 1, " ]";
                    push @queue, [ $new_board, $reduced_hand, $n_moves + 1 ];
                }
            }
        }
    }
    say "n_tries: $n_tries";
    return -1;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is zuma_game( "WRRBBW", "RB" ), -1,
    'Example 1: zuma_game( "WRRBBW", "RB" ) == -1';
is zuma_game( "WWRRBBWW", "WRBRW" ), 2,
    'Example 2: zuma_game( "WWRRBBWW", "WRBRW" ) == 2';
is zuma_game( "G", "GGGGG" ), 2,
    'Example 3: zuma_game( "G", "GGGGG" ) == 2';

done_testing;
