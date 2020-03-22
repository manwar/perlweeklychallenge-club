#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my @L = (-25, -10, -7, -3, 2, 4, 8, 10);
my $target = 0;

for my $i (0 .. $#L - 2) {
    for my $j ($i + 1 .. $#L - 1) {
        for my $k ( $j + 1 .. $#L) {
            say join ' + ', sort { $a <=> $b } @L[$i, $j, $k]
                if $target == $L[$i] + $L[$j] + $L[$k];
        }
    }
}
