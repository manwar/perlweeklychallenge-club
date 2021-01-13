#!/usr/bin/env perl

use 5.030;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

sub reverse_int($int) {
  # must fit into 32-bit signed integer
  return 0 unless -2_147_483_648 < $int && $int < 2_147_483_647;
  my @chars = split //, "$int";
  my $negative = defined($int < 0 ? shift @chars : undef);
  return join "", ($negative ? '-' : ''), reverse @chars;
}

sub main {
  die 'Integer required as input' unless
    my $input = int($ARGV[0]);

  say reverse_int($input);
}

main();

__DATA__

K #1 › Reverse Integer
Submitted by: Mohammad S Anwar

You are given an integer $N.

Write a script to reverse the given integer and print the result. Print 0 if the result doesn’t fit in 32-bit signed integer.

The number 2,147,483,647 is the maximum positive value for a 32-bit signed binary integer in computing.
Example 1:

Input: 1234
Output: 4321

Example 2:

Input: -1234
Output: -4321

Example 3:

Input: 1231230512
Output: 0



