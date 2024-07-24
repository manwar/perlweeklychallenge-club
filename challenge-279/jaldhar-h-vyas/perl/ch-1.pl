#!/usr/bin/perl
use v5.38;

my @letters = split /\s+/, $ARGV[0];
my @weights = split /\s+/, $ARGV[1];
my %h;

for my $key (keys @weights) {
    $h{$weights[$key]} = $letters[$key ];
}

say join q{}, map { $h{$_} } sort { $a <=> $b } keys %h;