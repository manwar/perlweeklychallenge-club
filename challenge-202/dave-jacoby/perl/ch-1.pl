#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [ 1, 5, 3, 6 ],
    [ 2, 6, 3, 5 ],
    [ 1, 2, 3, 4 ],
    [ 2, 3, 5, 7 ],
    [ 2, 3, 4, 7, 9, 11, 13 ],

);

for my $e (@examples) {
    my $list = join ',', $e->@*;
    my $out  = consecutive_odds( $e->@* );
    say <<"END";
    Input:  \@array = ($list)
    Output: $out
END
}

sub consecutive_odds ( @array ) {
    my $max = -3 + scalar @array;
OUTER: for my $i ( 0 .. $max ) {
        for my $j ( 0 .. 2 ) {
            my $n = $array[ $i + $j ];
            next OUTER if !is_odd($n);
            return 1   if $j == 2;
        }
    }
    return 0;
}

sub is_odd ( $n ) {
    return $n % 2 ? 1 : 0;
}
