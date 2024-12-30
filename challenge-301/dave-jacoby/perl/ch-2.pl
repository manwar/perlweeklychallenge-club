#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ max };

my @examples = (

    [ 4, 14, 2 ],
    [ 4, 14, 4 ],
    [ 0, 1,  2, 4, 32 ]
);

for my $example (@examples) {
    my $ints   = join ', ', $example->@*;
    my $output = hamming_distance( $example->@* );
    say <<"END";
    Input:  \@ints = ($ints)
    Output: $output
END
}

sub hamming_distance (@array) {
    my $o;
    my $end = -1 + scalar @array;
    for my $i ( 0 .. $end ) {
        my $ii = $array[$i];
        my $bi = sprintf '%08b', $ii;
        for my $j ( $i + 1 .. $end ) {
            my $jj = $array[$j];
            my $bj = sprintf '%08b', $jj;
            my $c  = count_diffs( $bi, $bj );
            $o += $c;
        }
    }
    return $o;
}

sub count_diffs( $str1, $str2 ) {
    my $max = max map { length $_ } $str1, $str2;
    my $o   = 0;
    for my $i ( 0 .. $max ) {
        $o++ if substr( $str1, $i, 1 ) ne substr( $str2, $i, 1 );
    }
    return $o;
}