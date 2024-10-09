#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( sum );

sub luhnCheck($num) {
  # just the numeric digits of the number
  my @digits = grep { /\d/ } split //, $num;
  # the last digit is the payload/checksum
  my $payload = pop @digits;

  my $to_be_summed;
  my $multiplier = 2; # we'll alternate between 2 & 1
  
  # pull the last digit off the number
  foreach my $digit (reverse @digits) {
    $to_be_summed .= $digit * $multiplier;
    # alternate the multiplier
    $multiplier = ($multiplier == 2) ? 1 : 2;
  }
  # add up the digits
  my $sum = sum(split //, $to_be_summed);
  # add the payload back in
  $sum += $payload;
  # is it a multiple of 10
  return $sum % 10 == 0 ? 'true' : 'false';
}

sub solution($num) {
  say qq{Input: "$num"};
  say 'Output: ' . luhnCheck($num);
}

say "Example 1:";
solution("17893729974");

say "\nExample 2:";
solution("4137 8947 1175 5904");

say "\nExample 3:";
solution("4137 8974 1175 5904");

