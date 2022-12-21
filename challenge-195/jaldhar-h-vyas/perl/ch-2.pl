#!/usr/bin/perl
use 5.030;
use warnings;

my @list = @ARGV;
my %count;

for my $elem (grep { $_ % 2 != 1; } @list) {
    $count{$elem}++;
}

say [sort { scalar $count{$b} <=> scalar $count{$a} || $a <=> $b } keys %count]->[0] || -1;
