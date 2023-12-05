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
        for my $p ( -100 .. 100 ) {
            my $pp = $p * $input[ $n - 2 ];
            for my $q ( -100 .. 100 ) {
                my $qq = $q * $input[ $n - 1 ];
                my $rr = $pp + $qq;
                next OUTER if $rr == $input[$n];
            }
        }
        return 'false';
    }
    return 'true';
}
