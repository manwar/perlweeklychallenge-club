#!/usr/bin/env raku
use v6;

sub luhnCheck($num) {
  # just the numeric digits of the number
  my @digits = $num.comb.grep( /\d/ );
  # the last digit is the payload/checksum
  my $payload = @digits.pop;

  my $to_be_summed;
  my $multiplier = 2; # we'll alternate between 2 & 1

  # pull the last digit off the number
  for @digits.reverse -> $digit {
    $to_be_summed ~= $digit.Int * $multiplier;
    # alternate the multiplier
    $multiplier = ($multiplier == 2) ?? 1 !! 2;
  }
  # add up the digits
  my $sum = [+] $to_be_summed.comb;
  # add the payload back in
  $sum += $payload;
  # is it a multiple of 10
  return $sum %% 10;
}

sub solution($num) {
  say qq{Input: "$num"};
  say 'Output: ' ~ luhnCheck($num);
}

say "Example 1:";
solution("17893729974");

say "\nExample 2:";
solution("4137 8947 1175 5904");

say "\nExample 3:";
solution("4137 8974 1175 5904");
