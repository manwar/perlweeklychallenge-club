#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [ 2, 5, 9 ],
    [ 7, 7, 7, 7, 7, 7, 7 ],
);

for my $e (@examples) {
    my $input  = join ', ', $e->@*;
    my $output = floor_sum( $e->@* );

    say <<~"END";
    Input:  \$input = ($input)
    Output:          $output
    END
}

sub floor_sum (@input) {
    my $output = 0;
    for my $i ( 0 .. -1 + scalar @input ) {
        my $ii = $input[$i];
        for my $j ( 0 .. -1 + scalar @input ) {
            my $jj    = $input[$j];
            my $floor = int( $ii / $jj );
            $output += $floor;
        }
    }
    return $output;
}
