#!/usr/bin/perl

# Weekly Challenge 131 Task #2
# Write a script to generate first 10 Smith Numbers in base 10.


use strict;
use warnings;
use List::Util 'sum';

my $number; 
my $sn=0;#$sn tracks number of Smith numbers found.
my @factors;
my $i; 
my $j=1;

# a is used to calculate sum of digits of a given number
# b is used to track and calculate sum of digits from prime factorization
my (@a, @b);
my ($a, $b);

while ($sn < 10) {
  undef($b);        # Reset prime factorization
  undef(@factors);
  $j++;
  $number = $j;
  @a = split(//,$number);
  $a = sum(@a);
 
# Is the number divisible by 2? 
  while ($number % 2 eq 0) {
    $number = $number / 2;
    unshift @factors, 2;
  }
# Numbers must be odd. Skip by 2s to find rest of prime factors
  for ($i = 3; $i< sqrt($number);$i+=2){
    while ($number % $i == 0) {
      unshift @factors, $i;
      $number = $number/$i;
    }
  }

  # Capture any large prime numbers
  if ($number > 2) {
    unshift @factors, $number;
  }

  next if $#factors eq 0; #Prime Number

  # Loop through all factors and sum the digits
  foreach(@factors) {
    @b = split(//,$_);
    $b+= sum(@b);
  }

  if ($a eq $b) {
    print "$j is a Smith number\n";
    $sn++;
  }
}
