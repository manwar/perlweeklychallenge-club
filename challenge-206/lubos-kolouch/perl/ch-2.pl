#!/usr/bin/perl

use strict;
use warnings;

# Use List::Util module
use List::Util qw(min max sum);

# Function to find the maximum sum of minimum of pairs in an array
sub max_sum_min_pairs {
  # Get the array as an argument
  my @array = @_;
  
  # Sort the array in ascending order using perl's sort function
  @array = sort {$a <=> $b} @array;
  
  # Initialize the sum variable to zero 
  my $sum = 0;
  
  # Loop through the sorted array and add the minimum of each pair to the sum 
  for (my $i = 0; $i < scalar(@array); $i += 2) {
    # Use min function from List::Util module
    $sum += min($array[$i], $array[$i+1]);
  }
  
  # Return the sum as output 
  return $sum;
}

# Define test cases
my @test1 = (1, 2, 3, 4);
my $expected1 = 4;
my @test2 = (0, 2, 1, 3);
my $expected2 = 2;

# Run tests
use Test::More;
is(max_sum_min_pairs(@test1), $expected1, "Example 1");
is(max_sum_min_pairs(@test2), $expected2, "Example 2");
done_testing();
