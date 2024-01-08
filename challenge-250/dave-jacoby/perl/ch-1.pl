#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ min };

my @examples = (

    [ 0, 1, 2 ],
    [ 4, 3, 2, 1 ],
    [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 ],
    [ 7, 7, 7, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 ],
);

for my $example (@examples) {
    my $input  = join ', ', $example->@*;
    my $output = smallest_index( $example->@* );

    say <<~"END";
    Input:  \$ints = ($input)
    Output: $output
    END
}

sub smallest_index (@input) {
    my @output;
    for my $i ( 0 .. -1 + scalar @input ) {
        my $j = $i % 10;
        push @output, $i if $input[$i] == $j;
    }
    return min @output if scalar @output;
    return -1;
}
