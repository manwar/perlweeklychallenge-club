#!/usr/bin/perl
use 5.038;
use warnings;

my $str = shift;
my $max = -"Inf";

for my $i (1 .. (length $str) - 1) {
    my $score = substr($str, 0, $i) =~ tr/0/0/ + substr($str, $i) =~ tr/1/1/;

    if ($score > $max) {
        $max = $score;
    }
}

say $max;
