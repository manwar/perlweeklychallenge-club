#!/usr/bin/perl -w
use strict;
use warnings;
use v5.26;
use DDP;
# TASK #1 › Min Sliding Window
# You are given an array of integers @A and sliding window size $S.

# Write a script to create an array of min from each sliding window.

# Example
# Input: @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8) and $S = 3
# Output: (0, 0, 0, 2, 3, 3, 4, 4)

# [(1 5 0) 2 9 3 7 6 4 8] = Min (0)
# [1 (5 0 2) 9 3 7 6 4 8] = Min (0)
# [1 5 (0 2 9) 3 7 6 4 8] = Min (0)
# [1 5 0 (2 9 3) 7 6 4 8] = Min (2)
# [1 5 0 2 (9 3 7) 6 4 8] = Min (3)
# [1 5 0 2 9 (3 7 6) 4 8] = Min (3)
# [1 5 0 2 9 3 (7 6 4) 8] = Min (4)
# [1 5 0 2 9 3 7 (6 4 8)] = Min (4)

my @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8);
my $S = 3;
my @O = ();

for (my $i=0; $i <= $#A; $i++)
{
  my $min = sliding($i);
  next unless defined $min;
  push @O, $min;
}

say join ',', @O;

sub sliding
{
  my $slide = shift;
  my @tmp = ();
  my $max = $S-1 + $slide;

  for ( my $i = $slide; $i <= $max; $i++ )
  {
    push @tmp, $A[$i] if defined $A[$max];
  }

  return (sort @tmp)[0];
}