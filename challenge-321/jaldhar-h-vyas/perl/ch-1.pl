#!/usr/bin/perl
use v5.38;

my @nums = sort { $a <=> $b } @ARGV;
my %distinct;

while (scalar @nums) {
    $distinct{($nums[0] + $nums[-1]) / 2}++;
    @nums = @nums[1 .. $#nums - 1];
}

say scalar keys %distinct;