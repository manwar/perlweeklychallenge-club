#!/usr/bin/env perl
use v5.40;

sub uniqueNumber(@ints) {
  my %bag;
  grep { $bag{$_}++ } @ints;  # count occurrences
  my @keys;
  foreach my($key, $value) (%bag) { # get key/value pairs
    next unless $value == 1; # just keys that occur once
    push @keys, $key; # return just the keys
  }

  # invalid input
  return 'no element appears only once'
    if @keys == 0;
  return 'multiple elements appear only once'
    if @keys > 1;

  # return the one value
  return shift @keys;
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  say 'Output: ' . uniqueNumber(@$ints);
}

say "Example 1:";
solution([3, 3, 1]);

say "\nExample 2:";
solution([3, 2, 4, 2, 4]);

say "\nExample 3:";
solution([1]);

say "\nExample 4:";
solution([4, 3, 1, 1, 1, 4]);

say "\nInvalid Input 1 (no element appears only once):";
solution([4, 1, 1, 1, 4]);

say "\nInvalid Input 2 (multiple elements appear only once):";
solution([1, 2, 3, 4]);
