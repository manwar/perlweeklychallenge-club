#!/usr/bin/perl

# Weekly Challenge 141 Task 1
#
# Write a script to find lowest 10 positive integers having exactly 8 divisors.

use strict;

my @numbers;
my @final;
my $i=8;
my $j=1;

# Loop through until 8 numbers are found.
while ($#final < 7) {
  # Loop through all possible divisors. Must
  # go through all of them up to the number
  # being tested to ensure there are only 8.
  for ($j=1; $j<=$i; $j++) {
    if (($i % $j) eq 0) {
      push @numbers, $i;
    }
  }
  push @final, $i if $#numbers == 7;
  $i++;
  undef(@numbers);
}

print "The first 8 integers to have exactly 8 divisors:\n@final\n";
