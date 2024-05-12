#!/usr/bin/perl
use v5.38;


my @x = sort { $a <=> $b } split /\s+/, $ARGV[0];
my @y = sort { $a <=> $b } split /\s+/, $ARGV[1];
my @diff;

for my $i (0 .. scalar @x - 1) {
    push @diff, $x[$i] - $y[$i];
}

for my $i (1 .. scalar @diff - 1) {
    if ($diff[$i] != $diff[0]) {
        say "no magic number";
        exit(0);
    }
}

say abs $diff[0];
