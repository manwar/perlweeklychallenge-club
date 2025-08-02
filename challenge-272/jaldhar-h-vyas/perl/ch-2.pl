#!/usr/bin/perl
use v5.38;

my $str = shift;
my @chars = split //, $str;
my $score;

for my $i (0 .. scalar @chars - 2) {
    $score += abs(ord($chars[$i]) - ord($chars[$i + 1]));
}

say $score;
