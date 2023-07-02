#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ product };

my @examples = ( [ 3, 1, 5, 8 ], [ 1, 5 ], );

for my $example (@examples) {
    my $input  = join ', ', $example->@*;
    my $output = box_coins( $example->@* );
    say <<~"END";
        INPUT: \@box =  ($input)
        Output: $output
    END
}

sub box_coins( @coins ) {
    my $total = 0;
    while (@coins) {
        if ( scalar @coins >= 3 ) {
            my $value = product @coins[ 0 .. 2 ];
            delete $coins[1];
            @coins = grep { defined } @coins;
            $total += $value;
        }
        elsif ( scalar @coins >= 2 ) {
            my $value = product @coins[ 0 .. 1 ];
            delete $coins[0];
            @coins = grep { defined } @coins;
            $total += $value;
        }
        else { $total += shift @coins; }
    }
    return $total;
}
