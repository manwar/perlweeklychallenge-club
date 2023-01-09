#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };
use Algorithm::Permute;

my @examples = (

    [ 7, 2, 3, 3, 0, 1, 1, 9, 7 ],
    [ 0, 0, 1, 1, 1, 2, 2, 3 ],

);

for my $e (@examples) {
    my $out  = good_triplets( $e->@* );
    my ( $x, $y, $z, @array ) = $e->@*;
    my $list = join ',', @array;
    say <<"END";
    Input:  \@array = ($list) and \$x = $x, \$y = $y, \$z = $z
    Output: $out
END
}

sub good_triplets ( $x, $y, $z, @array ) {
    my $out = 0;
    my $max = -1 + scalar @array;
    for my $i ( 0 .. $max ) {
        for my $j ( $i + 1 .. $max ) {
            for my $k ( $j + 1 .. $max ) {
                my $ij = abs( $array[$i] - $array[$j] );
                my $jk = abs( $array[$j] - $array[$k] );
                my $ik = abs( $array[$i] - $array[$k] );
                next unless $ij <= $x;
                next unless $jk <= $y;
                next unless $ik <= $z;
                $out ++;
            }
        }
    }

    return $out;
}

