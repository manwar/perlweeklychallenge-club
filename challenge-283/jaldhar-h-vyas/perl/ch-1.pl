#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;
my %count;

for my $int (@ints) {
    $count{$int}++;
}

say [sort { scalar $count{$a} <=> scalar $count{$b} } keys %count]->[0];
