#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

my @N = (1, 6, 8, 2, 4, 9, 12);
my $k = 3;
my @h = ();

$h[$_]++ for @N;
for my $x (0..$#N) {
    #effort to optimize for larger arrays.
    if ($h[$N[$x]+$k]) {
        for my $y ($x+1..$#N) {
            $k == abs $N[$x]-$N[$y] && say "$x\t$y";
        } 
    }
}
=begin
perl .\ch-1.pl
0       4
1       5
5       6
=cut