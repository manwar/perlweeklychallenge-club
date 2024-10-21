#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ first max };

my @examples = (

    [ 2, 4, 1, 0 ],
    [ 1 .. 4 ],
    [ 1, 3, 5, 7, 11 ],
    [ 1, 3, 5, 7, 15 ],
);

for my $example (@examples) {
    my $output = twice_largest( $example->@* );
    my $input  = join ', ', $example->@*;
    say <<"END";
    Input:  \$ints = ($input)
    Output: $output
END
}

sub twice_largest (@array) {
    my $max = max @array;
    my $i   = first { $array[$_] == $max } 0 .. -1 + scalar @array;
    for my $j ( 0 .. -1 + scalar @array ) {
        next if $i == $j;
        my $v = $array[$j];
        my $r = $max >= 2 * $v ? 1 : 0;
        if ( !$r ) {
            return -1;
        }
    }
    return $i;
}
