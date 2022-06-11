#!/usr/bin/perl
use 5.030;
use warnings;
use Math::Round qw/ nearest /;

my $count = 0;
for my $a (1 .. 100) {
    for my $b (1 .. 100) {
        for my $c (1 .. 100) {
            my $bc = $b * sqrt($c);
            my $left = ($a + $bc) ** (1/3);
            my $x = $a - $bc;
            my $right = ($x >= 0) ? $x ** (1/3) : -abs($x) ** (1/3);
            if (nearest(0.001, $left + $right) == 1.0) {
                $count++;
                say join q{, }, ($a, $b, $c);
                if ($count > 4) {
                    exit;
                }
            }
        }
    }
}
