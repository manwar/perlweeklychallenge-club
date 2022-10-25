#!/usr/bin/perl

# Weekly Challenge 187 Task #2
# You are given a list of positive numbers, @n, having at least 3 numbers.

# Write a script to find the triplets (a, b, c) from the given list that satisfies the following rules.
##############################
use strict;
use warnings;

my @numbers = (4,1,3,4,5);
print "You may enter your own numbers, simply enter them after the script name with spaces\n";
print "e.g. perl ch-2.pl 1 2 3 2\n\n";

if (@ARGV) {
  @numbers=@ARGV;
}

# Lazy way to get all possible permutations
# This gives too many, but it is sorted out later.
my $n = scalar(@numbers)-1;
my @perms = 0..$n;
my $perm = join(",",@perms);
my %perms = map { $_ => 1 } glob "{$perm}" x 3;
my @total=(0,0);

# Populate @perms with possible permutations of triplets
my @nums; my @output;
undef(@perms);
foreach my $key ( keys %perms) {
  @perms=(@perms,$key);
}

if ($#numbers < 2) {
  print "Less than 3 numbers, therefor no magical triplets\n";
  exit;
}
elsif ($#numbers >= 2) {
  foreach(@perms) { # Loops through all permutations
    @nums=split('',$_); Split them into their own array
    if($nums[0] eq $nums[1] || $nums[0] eq $nums[2] || $nums[1] eq $nums[2]) {
      next; #
    } # Eliminate duplicates numbers
    if ($numbers[$nums[0]] + $numbers[$nums[1]] > $numbers[$nums[2]]) { # Criteria 1
      if ($numbers[$nums[1]] + $numbers[$nums[2]] > $numbers[$nums[0]]) { # Criteria 2
        if ($numbers[$nums[0]] + $numbers[$nums[2]] > $numbers[$nums[1]]) { # Criteria 3
          # All criteria met. Calculate the total.
          $total[1]=($numbers[$nums[0]]+$numbers[$nums[1]]+$numbers[$nums[2]]);
          if ($total[1] ge $total[0]) {
            # Total is greater than (or equal) than previous triplet
            if ($numbers[$nums[0]] >= $numbers[$nums[1]] && $numbers[$nums[1]] >= $numbers[$nums[2]]) {
              # Criteria #4
              $total[0] = $total[1];
              @total=($total[0],$total[1],$numbers[$nums[0]],$numbers[$nums[1]],$numbers[$nums[2]]);
            }
          }
        }
      }
    }      
  }
}

if ($#total eq 4) {
  print "Input: \@n = @numbers\n";
  print "Output: $total[2],$total[3],$total[4]\n";
}
else {
  print "Input: \@n = @numbers\n";
  print "No magic triplets found. Good bye!\n";
}
