#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub perfectCandidate {
    my ($p) = @_;

    my $q = 2 ** $p - 1;
    return $q * ($q + 1) / 2;
}

sub isPerfect {
    my ($number) = @_;

    my $total = 0;
    for my $i (1 .. $number) {
        if ($number % $i == 0) {
            $total += $i;
        }
    }

    return ($total / 2  == $number);
}

my @perfects;
my $n = 1;
while (scalar @perfects < 5) {
    my $number = perfectCandidate($n);
    if (isPerfect($number)) {
        push @perfects, $number;
    }
    $n++;
}

say join q{ }, @perfects;
