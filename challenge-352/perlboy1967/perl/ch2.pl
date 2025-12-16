#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-352#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Binary Prefix
Submitted by: Mohammad Sajid Anwar
You are given an array, @nums, where each element is either 0 or 1.

Define xi as the number formed by taking the first i+1 bits of @nums (from $nums[0] to $nums[i])
and interpreting them as a binary number, with $nums[0] being the most significant bit.

For example:

If @nums = (1, 0, 1), then:

x0 = 1 (binary 1)
x1 = 2 (binary 10)
x2 = 5 (binary 101)

For each i, check whether xi is divisible by 5.
Write a script to return an array @answer where $answer[i] is true if xi is divisible by 5, otherwise false.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use boolean;

sub binaryPrefix (@nums) {
  my ($d,$c);
  map { 
    $d .= $_; 
    $c = substr(eval "0b$d",-1,1); 
    boolean($c eq '0' or $c eq '5')
  } @nums;
}

is([binaryPrefix(0,1,1,0,0,1,0,1,1,1)],
   [true,false,false,false,false,true,true,false,false,false],'Example 1');
is([binaryPrefix(1,0,1,0,1,0)],
   [false,false,true,true,false,false],'Example 2');
is([binaryPrefix(0,0,1,0,1)],
   [true,true,false,false,true],'Example 3');
is([binaryPrefix(1,1,1,1,1)],
   [false,false,false,true,false],'Example 4');
is([binaryPrefix(1,0,1,1,0,1,0,0,1,1)],
   [false,false,true,false,false,true,true,true,false,false],'Example 5');

done_testing;
