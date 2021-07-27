#!/usr/bin/perl
use 5.020;
use warnings;

my $total = 0;
my $count = 1;
my @averages;

for  my $arg (@ARGV) {
    $total += $arg;
    push @averages, $total / $count++;
}

say join q{ }, @averages;
