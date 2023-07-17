#!/usr/bin/perl
use 5.030;
use warnings;

my $string = shift @ARGV;
my @indices = @ARGV;
my @letters = split //, $string;
my @result;

for my $i (0 .. scalar @indices - 1) {
    $result[$indices[$i]] = $letters[$i];
}

say join q{}, @result;
