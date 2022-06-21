#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @pairs;
push @pairs, [ [ [ 1, 2 ], [ 3, 4 ] ], [ [ 5, 6 ], [ 7, 8 ] ], ];
push @pairs,
    [
    [ [ 1, 1, 1 ], [ 2, 2, 2 ], [ 3, 3, 3 ] ],
    [ [ 7, 8, 9 ], [ 3, 4, 5 ], [ 5, 6, 7 ] ],
    ];
push @pairs, [ [ [ 9, 0, 2 ], [ 9, 0, 1 ] ], [ [ 1, 2, 3 ], [ 9, 8, 7 ] ], ];

for my $m (@pairs) {
    my @matrices = $m->@*;
    my @out      = kronecker(@matrices);
    say '';
    say join "\n", map { join "\t", $_->@* } @out;
    say '';
}

exit;

sub kronecker ( $ma, $mb ) {
    my @output;
    my $ax = -1 + scalar $ma->@*;
    my $ay = -1 + scalar $ma->[0]->@*;
    my $bx = -1 + scalar $mb->@*;
    my $by = -1 + scalar $mb->[0]->@*;

    for my $x1 ( 0 .. $ax ) {
        for my $x2 ( 0 .. $bx ) {
            my $x = ( 1 + $bx ) * $x1 + $x2;
            for my $y1 ( 0 .. $ay ) {
                for my $y2 ( 0 .. $by ) {
                    my $y  = ( 1 + $by ) * $y1 + $y2;
                    my $v1 = $ma->[$x1][$y1];
                    my $v2 = $mb->[$x2][$y2];
                    my $v  = $v1 * $v2;
                    $output[$x][$y] = $v;
                }
            }
        }
    }

    return @output;
}
