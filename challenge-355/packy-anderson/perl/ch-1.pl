#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( bundle_by );

sub thousandSeparator($int) {
  # flow goes from bottom to top
  scalar reverse               # reverse the string
  join ',',                    # join the strings with comma
  bundle_by { join "", @_ } 3, # return a list of 3 char strings
  reverse                      # reverse the list
  split //, $int;              # break the string into chars
}

sub solution($int) {
  say 'Input: $int = ' . $int;
  say 'Output: "' . thousandSeparator($int) . '"';
}

say "Example 1:";
solution(123);

say "\nExample 2:";
solution(1234);

say "\nExample 3:";
solution(1000000);

say "\nExample 4:";
solution(1);

say "\nExample 5:";
solution(12345);
