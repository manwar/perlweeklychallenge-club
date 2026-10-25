#!/usr/bin/perl
use 5.40.1;
use warnings;

my @N = @ARGV;
my %count;

for my $n (@N) {
    $count{$n}++;
}

say grep { $count{$_} % 2 == 1 } keys %count;

