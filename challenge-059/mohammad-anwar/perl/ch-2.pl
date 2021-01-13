#!/usr/bin/perl

use strict;
use warnings;

use Algorithm::Combinatorics qw(combinations);

print &s([2, 3, 4]);

sub s {
    my ($A) = @_;

    my $sum = 0;
    foreach my $pair (combinations($A, 2)) {
        $sum += f(@$pair);
    }

    return $sum;
}

sub f {
    my ($a, $b) = @_;

    $a = sprintf("%b", $a);
    $b = sprintf("%b", $b);

    my $m = length($a) > length($b) ? length($a) : length($b);
    my $f = '%0'.$m.'d';
    my @a = split //, sprintf $f, $a;
    my @b = split //, sprintf $f, $b;

    my $bits = 0;
    foreach (0..$m-1) {
        $bits += 1 if ($a[$_] != $b[$_]);
    }

    return $bits;
}
