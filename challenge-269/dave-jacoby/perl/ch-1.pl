#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ bitwise fc postderef say signatures state };

my @examples = (

    [ 1, 2, 3, 4, 5, ], 
    [ 2, 3, 8, 16, ], 
    [ 1, 2, 5, 7, 9, ],
);
for my $example (@examples) {
    my $output = bitwise_or_fun(@$example);
    $output = $output ? 'true' : 'false';
    my $array = join ', ', $example->@*;
    say <<"END";
    Input:  \@array = ($array)
    Output: $output
END
}

sub bitwise_or_fun (@array) {
    my @copy = @array;
    for my $i ( 0 .. -1 + scalar @array ) {
        for my $j ( $i + 1 .. -1 + scalar @array ) {
            my $x = $array[$i];
            my $y = $array[$j];
            my $z = $x | $y;
            return 1 if $z % 2 == 0;
        }
    }
    return 0;
}
