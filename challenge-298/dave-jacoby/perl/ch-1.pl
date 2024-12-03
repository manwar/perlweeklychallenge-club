#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (
    [
        [ 1, 0, 1, 0, 0 ],
        [ 1, 0, 1, 1, 1 ],
        [ 1, 1, 1, 1, 1 ],
        [ 1, 0, 0, 1, 0 ]
    ],
    [ [ 0, 1 ], [ 1, 0 ] ],
    [
        [ 1, 1, 1, 0, 0, 0, 0, 0 ],
        [ 1, 1, 1, 0, 0, 0, 0, 0 ],
        [ 1, 1, 1, 1, 1, 0, 0, 0 ],
        [ 0, 0, 1, 1, 1, 1, 1, 1 ],
        [ 0, 0, 1, 1, 1, 1, 1, 1 ],
        [ 0, 0, 0, 0, 0, 1, 1, 1 ],
        [ 0, 0, 0, 0, 0, 0, 1, 1 ],
        [ 0, 0, 0, 0, 0, 0, 0, 0 ],
    ],
    [
        [ 1, 1, 1, 1, 1 ],
        [ 1, 1, 1, 1, 1 ],
        [ 1, 1, 1, 1, 1 ],
        [ 1, 1, 1, 1, 1 ],
    ],
);

for my $example (@examples) {
    my $input  = display_matrix( $example, 22 );
    my $output = maximal_square($example);

    say <<"END";
    Input:  \$matrix = $input
    Output: $output
END
}

sub maximal_square ($matrix) {
    my $max = -1;
    for my $i ( 0 .. -1 + scalar $matrix->@* ) {
        for my $j ( 0 .. -1 + scalar $matrix->[$i]->@* ) {
            my $v = $matrix->[$i][$j];
            if ( $v == 1 ) {
                my $l = 0;
            OUTER: while (1) {
                    for my $m ( 0 .. $l ) {
                        my $mi = $m + $i;
                        last OUTER unless defined $matrix->[$mi];
                        for my $n ( 0 .. $l ) {
                            my $nj = $n + $j;
                            last OUTER unless defined $matrix->[$mi][$nj];
                            my $v = $matrix->[$mi][$nj];
                            last OUTER unless $v == 1;
                        }
                    }
                    $l++;
                    $max = $l if $max < $l;
                }
            }
        }
    }
    return $max;
}

sub display_matrix ( $matrix, $size = 5 ) {
    my $pad = ' ' x $size;
    return join ",\n$pad", map {
        join ' ', '[', ( join ', ', map { qq{'$_'} } $_->@* ), ']'
    } $matrix->@*;
}
