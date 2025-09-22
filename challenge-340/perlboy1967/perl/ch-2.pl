#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-340#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Ascending Numbers
Submitted by: Mohammad Sajid Anwar

You are given a string, $str, is a list of tokens separated by a single space. Every token
is either a positive number consisting of digits 0-9 with no leading zeros, or a word
consisting of lowercase English letters.

Write a script to check if all the numbers in the given string are strictly increasing from
left to right.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use boolean;
use List::MoreUtils qw(slide);

sub containsAscendingNumbers ($str) {
  #boolean ((grep { $_ >= 0 } slide { $a <=> $b } grep /\d/, split(/\D+/,$str)) == 0);
  boolean !grep { $_ >= 0 } slide { $a <=> $b } grep /\d/, split(/\D+/,$str);
}

is(containsAscendingNumbers('The cat has 3 kittens 7 toys 10 beds'),
                            true,'Example 1');
is(containsAscendingNumbers('Alice bought 5 apples 2 oranges 9 bananas'),
                            false,'Example 2');
is(containsAscendingNumbers('I ran 1 mile 2 days 3 weeks 4 months'),
                            true,'Example 3');
is(containsAscendingNumbers('Bob has 10 cars 10 bikes'),
                            false,'Example 4');
is(containsAscendingNumbers('Zero is 0 one is 1 two is 2'),
                            true,'Example 5');

done_testing;
