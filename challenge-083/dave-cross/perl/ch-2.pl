#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use List::Util qw[sum];

my @ints = grep { !/\D/ and $_ } @ARGV;

die "Please give me some positive integers\n" unless @ints;

my $options = 2 ** @ints - 1;

my $lowest_sum = sum @ints;
my $fewest_flips = @ints;
my $number_of_flags = @ints;

for (0 .. $options) {
  my $binary = sprintf "%0${number_of_flags}b", $_;
  my @flags = split //, $binary;
  my $number_of_on_flags = grep { $_ } @flags;

  my $total = sum map {
    $flags[$_] ? -$ints[$_] : $ints[$_];
  } 0 .. $#flags;

  next if $total < 0;

  if ($total < $lowest_sum or
      $total == $lowest_sum and $number_of_on_flags < $fewest_flips) {
    $lowest_sum = $total;
    $fewest_flips = $number_of_on_flags;
  }
}

say $fewest_flips;
