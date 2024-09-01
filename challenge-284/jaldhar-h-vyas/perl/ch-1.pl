#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;
my %count;

for my $int (@ints) {
    $count{$int}++;
}

say [sort { $b <=> $a} grep { $_ == $count{$_} } keys %count]->[0] // -1;
