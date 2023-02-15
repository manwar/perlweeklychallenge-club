#!/usr/bin/perl

use strict;
use warnings;

# function to check if an array is monotonic
sub is_monotonic {
  my @nums = @_;
  my $increasing = 1;
  my $decreasing = 1;

  for (my $i = 0; $i < $#nums; $i++) {
    if ($nums[$i] > $nums[$i + 1]) {
      $increasing = 0;
    }
    if ($nums[$i] < $nums[$i + 1]) {
      $decreasing = 0;
    }
  }

  return $increasing || $decreasing;
}

# test cases
my @test_cases = (
  [1, 2, 3, 4, 5],
  [5, 4, 3, 2, 1],
  [1, 1, 1, 1, 1],
  [1, 2, 3, 2, 1],
  [5, 3, 2, 4, 3],
);

foreach my $test_case (@test_cases) {
  my $result = is_monotonic(@$test_case);
  my $output = $result ? 1 : 0;
  print "Array @$test_case is monotonic: $output\n";
}

