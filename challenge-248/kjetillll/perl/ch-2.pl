#!/usr/bin/perl
#https://theweeklychallenge.org/blog/perl-weekly-challenge-248/
use strict; use warnings; use Test::More tests=>2;

is_deeply [ sum2x2(
                [1,  2,  3,  4],
                [5,  6,  7,  8],
                [9, 10, 11, 12] )
          ] => [
                [14, 18, 22],
                [30, 34, 38]
          ];

is_deeply [ sum2x2(
                [1, 0, 0, 0],
                [0, 1, 0, 0],
                [0, 0, 1, 0],
                [0, 0, 0, 1] )
          ] => [
                [2, 1, 0],
                [1, 2, 1],
                [0, 1, 2]
          ];

sub slide_matrix (&$$$) {
    my($sub, $w, $h, $m) = @_;
    for my $i ( 0 ..  @$m - $h ) {
        for my $j ( 0 .. @{ $$m[0] } - $w ){
            my @sm;
            for my $x ( 0 .. $w-1 ) {
                for my $y ( 0 .. $h-1 ) {
                    $sm[$x][$y] = $$m[$i+$x][$j+$y]
                }
            }
            &$sub(\@sm,$i,$j)
        }
    }
}

sub sum2x2 {
    my @matrix = @_;
    my @result;
    slide_matrix {
        my($subm, $i, $j) = @_;
        push @{ $result[$i] //= [] },  $$subm[0][0] + $$subm[0][1]
                                     + $$subm[1][0] + $$subm[1][1];
    } 2, 2, \@matrix;
    @result
}
