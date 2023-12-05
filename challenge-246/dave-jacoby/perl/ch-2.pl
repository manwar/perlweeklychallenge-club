#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [ 1, 1, 2, 3,  5 ],
    [ 4, 2, 4, 5,  7 ],
    [ 4, 1, 2, -3, 8 ],
);

for my $e (@examples) {
    my $input  = join ', ', $e->@*;
    my $output = lrso( $e->@* );

    say <<~"END";
    Input:  \$input = ($input)
    Output:          $output
    END
}

sub lrso (@input) {
OUTER: for my $n ( 2 .. -1 + scalar @input ) {
        for my $p ( 1 .. 100 ) {
            for my $pp ( 1, -1 ) {
                my $ppp = ( $p * $pp ) * $input[ $n - 2 ];
                for my $q ( 1 .. 100 ) {
                    for my $qq ( 1, -1 ) {
                        my $qqq = ( $q * $qq ) * $input[ $n - 1 ];
                        my $rrr = $ppp + $qqq;
                        next OUTER if $rrr == $input[$n];
                    }
                }
            }
        }
        return 'false';
    }
    return 'true';
}
