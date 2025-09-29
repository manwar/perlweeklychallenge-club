#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-341#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Reverse Prefix
Submitted by: Mohammad Sajid Anwar

You are given a string, $str and a character in the given string, $char.

Write a script to reverse the prefix upto the first occurrence of the given
$char in the given string $str and return the new string.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub reversePrefix ($str,$char) {
  $str = $char.reverse ($1).$2 if ($str =~ m#^(.*?)$char(.*)#);
  return $str;
}

is(reversePrefix('programming','g'),'gorpramming','Example 1');
is(reversePrefix('hello','h'),'hello','Example 2');
is(reversePrefix('abcdefghij','h'),'hgfedcbaij','Example 3');
is(reversePrefix('reverse','s'),'srevere','Example 4');
is(reversePrefix('perl','r'),'repl','Example 5');

done_testing;
