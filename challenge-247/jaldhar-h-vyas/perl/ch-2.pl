#!/usr/bin/perl
use 5.030;
use warnings;

my @chars = split //, shift @ARGV;
my %pairs;

for my $i (1 .. scalar @chars - 1) {
    $pairs{join q{}, ($chars[$i - 1], $chars[$i])}++;
}

say [sort { $pairs{$b} <=> $pairs{$a} || $a cmp $b } keys %pairs]->[0];
