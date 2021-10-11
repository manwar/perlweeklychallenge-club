#!/usr/bin/perl

# Weekly Challenge 131 Task #1
# Write a script to calculate the integer square root of the given number.

use strict;
use warnings;

my @set=();
my $subtract = 1;
my ($answer, $number);

# Get input from user or use test set;
if ($ARGV[0]) {
  $set[0] = $ARGV[0];
}
else {
  print "Script accepts an integer as input. With no input, it uses a test set of numbers\n"; 
  sleep(1);
  print "Test set of numbers: 10, 27, 85, 101.\n";
  @set = qw (10 27 85 101);
}

# Loop through input numbers
foreach(@set) {
  $number = $_;
  $subtract=0;
  $answer=0;

# Used repeat subtraction method to get calcuate integer square root
# When number is less than or equal than value of subraction, it has been found
  until ($number <= $subtract) {
    $number = $number - $subtract;
    $subtract+=2;
    $answer++; # Square root value
  }
  print "Integer square root of $_ is $answer.\n\n";
}
