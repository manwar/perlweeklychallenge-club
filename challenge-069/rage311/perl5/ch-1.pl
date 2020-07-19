#!/usr/bin/env perl

use 5.032;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use constant INVERTED => {
  0 => 0,
  1 => 1,
  8 => 8,
  6 => 9,
  9 => 6,
};

sub strobotize ($number) {
  my @digits = split //, $_;
  return () if grep { !exists INVERTED->{$_} } @digits;

  my $odd_len = @digits % 2;
  my $middle = $digits[int @digits / 2];
  return () if $odd_len && $middle != 0 && $middle != 1 && $middle != 8;

  for (0 .. $#digits) {
    return () if $digits[$_] != INVERTED->{$digits[$#digits - $_]}
  }

  return $number;
}

sub test {
  require Test::More;

  my ($start, $end) = (0, 10000);
  my $expected = [
    0, 1, 8, 11, 69, 88, 96, 101, 111, 181, 609, 619, 689, 808, 818, 888, 906, 916, 986, 1001, 1111, 1691, 1881, 1961, 6009, 6119, 6699, 6889, 6969, 8008, 8118, 8698, 8888, 8968, 9006, 9116, 9696, 9886, 9966
  ];

  my $strobos = [ map { strobotize($_) } $start .. $end ];
  Test::More::is_deeply($strobos, $expected);
  Test::More::done_testing();
}

my ($start, $end) = @ARGV;
say for map { strobotize($_) } $start .. $end;


__DATA__

TASK #1 › Strobogrammatic Number
Submitted by: Mohammad S Anwar

A strobogrammatic number is a number that looks the same when looked at upside down.

You are given two positive numbers $A and $B such that 1 <= $A <= $B <= 10^15.

Write a script to print all strobogrammatic numbers between the given two numbers.
Example

Input: $A = 50, $B = 100
    Output: 69, 88, 96

