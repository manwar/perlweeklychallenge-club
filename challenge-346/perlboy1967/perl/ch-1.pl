#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-346#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Longest Parenthesis
Submitted by: Mohammad Sajid Anwar

You are given a string containing only ( and ).

Write a script to find the length of the longest valid parenthesis.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(max);

sub longestParenthesis ($str) {
  my ($maxLen,$i,@stack) = (0,0,-1);
  for (split//,$str) {
   if ($_ eq '(') { 
     push @stack,$i;
   } else { 
     pop @stack;
     if (@stack) {
       $maxLen = max($maxLen,$i - $stack[-1]);
     } else {
       push @stack, $i;
     }
   }
   $i++;
 }
 return $maxLen;
}

is(longestParenthesis('(()())'),6,'Example 1');
is(longestParenthesis(')()())'),4,'Example 2');
is(longestParenthesis('((()))()(((()'),8,'Example 3');
is(longestParenthesis('))))((()('),2,'Example 4');
is(longestParenthesis('()(()'),2,'Example 5');

done_testing;
