#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (
    [ 1, 2, 3, 4 ],
    [ 2, 4, 6, 8, 9, 10, 11 ],
    [2],

);

for my $e (@examples) {
    my @out = arithmatic_slices( $e->@* );
    my $out = join ', ', map { "($_)" } map { join ',', $_->@* } @out;
    my $in  = join ',',  $e->@*;
    say <<"END";
    Input:  \@array = ($in) 
    Output: ($out)
END
}

sub arithmatic_slices ( @array ) {
    return () if scalar @array < 3;
    my @output;
    my $max = -1 + scalar @array;
OUTER: for my $i ( 0 .. $max - 1) {
        my $diff = abs( $array[$i] - $array[ $i + 1 ] );
        my @slice;
        push @slice, $array[$i];
        for my $j ( $i + 1 .. $max ) {
            my $ldiff = abs( $array[$j] - $array[ $j - 1 ] );
            if ( $ldiff == $diff ) {
                push @slice, $array[$j];
                my @copy = @slice;
                push @output, \@copy if scalar @slice > 2;
            }
            else {
                next OUTER;
            }
        }
    }
    # first sort makes the arrays numerically sorted by first value
    # second sort makes the arrays sorted by length
    @output = sort { scalar $a->@* <=> scalar $b->@* }
        sort { $a->[0] <=> $b->[0] } @output;
    return @output;
}
