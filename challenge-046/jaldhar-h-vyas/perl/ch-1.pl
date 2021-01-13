#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my @message = (
    [ qw{ P + 2 l ! a t o }],
    [ qw{ 1 e 8 0 R $ 4 u }],
    [ qw{ 5 - r ] + a > / }],
    [ qw{ P x w l b 3 k \ }],
    [ qw{ 2 e 3 5 R 8 y u }],
    [ qw{ < ! r ^ ( ) k 0 }],
);

my @rotated;

for my $i (0 .. scalar @message - 1) {
    for my $j (0 .. scalar @{$message[$i]} - 1) {
        push @{$rotated[$j]}, $message[$i][$j];
    }
}

say join q{}, map { /(.)\1/; $1; } map { join q{}, sort @{$_}; } @rotated;
