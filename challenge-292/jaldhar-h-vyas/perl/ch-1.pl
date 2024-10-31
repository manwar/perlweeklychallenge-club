#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;

my %h;
for my $i (keys @ints) {
    $h{$ints[$i]} = $i;
}

my @sorted = sort { $a <=> $b} keys %h;

say $sorted[-1] >= $sorted[-2] * 2 ? $h{$sorted[-1]} : '-1';
