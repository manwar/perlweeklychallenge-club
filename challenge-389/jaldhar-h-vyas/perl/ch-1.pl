#!/usr/bin/perl
use 5.40.1;
use warnings;

my $composer = $ARGV[0];
my @notes = split /\s+/, $ARGV[1];
my @permutation = split /\s+/, $ARGV[2];

my %reorder =  map { $permutation[$_] => $notes[$_] } keys @permutation;
say uc $composer, ' => ',
    (join q{ }, map { $reorder{$_} } sort { $a <=> $b } keys %reorder );
