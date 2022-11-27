#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw'min sum';

sub main (@nums) {
    # See if there is a possible target
    my $target = sum(@nums) / scalar(@nums);
    my $items  = scalar(@nums);
    my $moves  = 0;

    if ( $target != int($target) ) {
        # There is no possible solution
        say '-1';
        return;
    }

    foreach my $i ( 0 .. $#nums ) {
        # How many do we need to make the value the target
        my $needed = $target - $nums[$i];

        while ( $needed > 0 ) {
            # Loop from the left to find which items we can remove numbers from
            foreach my $j ( 0 .. $#nums ) {
                my $has = $nums[$j];

                # We have found a value we can take from
                if ( $has > $target ) {
                    # Calculate how many we can take
                    my $take = min( $needed, $has - $target );

                    $nums[$i] += $take;
                    $nums[$j] -= $take;
                    $needed   -= $take;

                    # Record the number of moves it would take to steal
                    #  from the other item
                    $moves += $take * abs( $i - $j );
                }
            }
        }
    }

    say $moves;
}

main(@ARGV)
