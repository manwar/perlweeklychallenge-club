#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = ( 27, 0, 6 );

for my $example (@examples) {
    my $output    = three_power($example);
    say $output;

    say <<~"END";
    Input:  \$n = $example
    Output: $output
    END
}

sub three_power ($input) {
    my $cuberoot= $input ** (1/3);
    return ( $cuberoot == int $cuberoot ) ? 'true' : 'false';
}
