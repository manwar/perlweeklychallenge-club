#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{any sum0};

my @examples = (

    [ 2, 2, 2, 2 ],
    [ 1, 2, 2, 2, 1 ],
    [ 2, 2, 2, 4 ],
    [ 2, 2, 2, 2, 4 ],
    [ 3, 4, 1, 4, 3, 1 ],
    [ 1, 1, 1, 1, 1, 5, 2, 3, 4, 1 ],
    [ 2, 3, 2, 3, 4, 1, 4, 1 ]
);

for my $example (@examples) {
    my $output = matchstick_square($example);
    my $input  = join ', ', $example->@*;
    say <<"END";
    Input:  \$ints = ($input)
    Output: $output
END
}

sub matchstick_square( $sticks, $board = [], $side = 0 ) {
    if ( $side > 3 ) {
        my @summed = map { sum0( $_->@* ) } $board->@*;
        if (   $summed[0] == $summed[1]
            && $summed[0] == $summed[2]
            && $summed[0] == $summed[3]
            && !scalar $sticks->@* )
        {
            return 'true';
        }
        return 'false';
    }
    my @output;
    my @sticks = $sticks->@*;
    for my $i ( 0 .. -1 + scalar @sticks ) {
        next if any { /true/mix } @output;
        my $stick = shift @sticks;
        my @board = map { [@$_] } $board->@*;
        push $board[$side]->@*, $stick;
        if ( $side == 0 ) {
            push @output, matchstick_square( \@sticks, \@board, $side );
            push @output, matchstick_square( \@sticks, \@board, $side + 1 );
        }
        elsif ( sum0( $board[$side] ) >= sum0( $board[0] ) ) {
            push @output, matchstick_square( \@sticks, \@board, $side + 1 );
        }
        else {
            push @output, matchstick_square( \@sticks, \@board, $side );
        }
        push @sticks, $stick;
    }
    if ( any { /true/mix } @output ) {
        return 'true';
    }
    return 'false';
}
