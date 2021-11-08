#/usr/bin/perl

# Weekly Challenge 119 Task #2
# Write a script to generate sequence starting at 1. Consider the 
# increasing sequence of integers which contain only 1’s, 2’s and 
# 3’s, and do not have any doublets of 1’s like below. Please 
# accept a positive integer $N and print the $Nth term in the 
# generated sequence.

# 1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131

use strict;
use warnings;

use POSIX;

my $input = $ARGV[0];
my @numbers;

my ($quo, $rem, $i);
my $check=0;
my ($oneone, $output);

for ($i=1;$i<$input+1;$i++) {
  $quo = $i;
  # Calculate base 4 number
  # Later throw out any values with 0
  while ($quo ne 0) {
    $rem = floor($quo % 4);
    unshift @numbers, $rem;
    $quo = floor($quo/4); 
  }
  # Check for any digit with a 0
  foreach (@numbers) {
    if ($_ eq 0) {
      $check=1;
      next;
    }
    $oneone.=$_;
  }

  # Check if any digits are consecutive ones or if one was a 0;
  if ($oneone =~ m/11/ || $check eq 1) {
    undef($oneone);
    undef(@numbers);
    $check = 0;
    $input++;
    next;
  }
  
  $output = $oneone;
  undef(@numbers);
  undef($oneone);
}

print "INPUT: \$N = $ARGV[0]\n";
print "OUTPUT: $output\n";

