#!/usr/bin/perl

# Weekly Challenge 141 Task 2
#
# You are given positive integers, $m and $n.
#
# Write a script to find total count of integers created using the digits of 
# $m which is also divisible by $n.
#
# Repeating of digits are not allowed. Order/Sequence of digits can’t be altered. 
# You are only allowed to use (n-1) digits at the most. For example, 432 is not 
# acceptable integer created using the digits of 1234. Also for 1234, you can only 
# have integers having no more than three digits.

use strict;
use warnings;

my ($m, $n, $nums);

if ($#ARGV eq 1) {
  $m = $ARGV[0];
  $n = $ARGV[1];
}
else {
  print "Using test data. Provide 2 input numbers to test your own numbers.\n";
  $m = 1234;
  $n = 2;
}

# Split the input integer into an array.
# Will use it to construct numbers later.

my @number = split(//,$m);
my (@final, @all_nums, @dfinal);
my (@arr, @sarr, @uarr);

my $i=1;
my $j=length($m);

# Create a string from an array from digit 1 up to the maximum digit.
my $digits = join(",",(1..$j));

# All nums will possess all length-1 combinations of the digits spot.
until ($i eq $j) {
  @arr = glob "{$digits}" x $i;
  push @all_nums, @arr;
  $i++;
}

# Loop through all of our possible digit place combinations.
for my $z (@all_nums) {
  @arr = split(//,$z);
  @uarr = uniq(@arr);

  # Check that there were no repeated digits.
  if (@arr ne @uarr) {
    next;
  }

  # Produce a sort array. Order/sequence matters
  @sarr = sort(@arr);

  # Use an arry match operator to compare original array vs the sorted. 
  # If it's not a match, then it's not in the correct order.
  if (@arr ~~ @sarr) {
    # Do nothing, it's a match. I don't know how to calculate the opposite of this.
  }
  else {
    next;
  }

  # With a valid sequence of digits, the number can be "constructed"
  # Because I used digit places, need to use that digit place and the
  # original array that the number was dumped into (@number);
  foreach(@arr) {
    $nums.=$number[$_-1];
  }
  push @final, $nums;
  undef($nums);
}

# Sort the possible integers created using the digits.
@final = sort { $a <=> $b } @final;

for my $y (@final) {
  if (($y % $n) == 0) {
    push @dfinal, $y
  }
}
print "Possible integers created using the digits of $m are:\n@final.\n\n";
print "There are ".@dfinal." integers divisible by $n such as:\n@dfinal.\n\n";

# subroutine uniq
# Subroutine is used to determine if elements in an array are unique
sub uniq {
  my %hash;
  grep !$hash{$_}++, @_;
}
# End of subroutine uniq ############################################
