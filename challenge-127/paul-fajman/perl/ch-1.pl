#!/usr/bin/perl

# Weekly Challenge 127 Task #1
# You are given two sets with unique integers.
# Write a script to figure out if they are disjoint.

use strict;
use warnings;

my @set1 = qw (1 2 5 3 4);
my @set2 = qw (4 6 7 8 9);

my @set3 = qw (1 3 5 7 9);
my @set4 = qw (0 2 4 6 8);

my @test=(1,1); my $num; my $i;

# Set this up to pass array reference to subroutine
my $set1_ref = \@set1;
my $set3_ref = \@set3;
my $set2_ref = \@set2;
my $set4_ref = \@set4;
my @set_arrays = ($set1_ref, $set2_ref, $set3_ref, $set4_ref);

my $array_ref1; my @array_ref1;
my $array_ref2; my @array_ref2;

# Loop over all the arrays for comparison. Count by two as comparison is between 2 arrays.
for ($i=0; $i<$#set_arrays; $i+=2) {
  $array_ref1 = $set_arrays[$i];
  @array_ref1 = @$array_ref1;
  $array_ref2 = $set_arrays[$i+1];
  @array_ref2 = @$array_ref2;

  # Loop over values from the array;
  foreach(@array_ref1) {
    $num = $_; # Value to test
    if (grep /$num/, @array_ref2) { # Test if the value is in the array.
      $test[0] = 0;
      $test[1] = $num;      
      last;
    }
  }
  # Print the output
  print "\nInput: \@S1 = (@array_ref1)\n";
  print "       \@S2 = (@array_ref2)\n";
  if ($test[0] eq 0) {
    print "Output: $test[0] as the given two sets have common member $test[1]\n";
  }
  else {
    print "Output: $test[0] as the given two sets do no have a common member\n";
  }
  @test=(1,1);
}
