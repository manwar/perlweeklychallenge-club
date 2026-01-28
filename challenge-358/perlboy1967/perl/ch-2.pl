#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-358#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Encrypted String
Submitted by: Mohammad Sajid Anwar

You are given a string $str and an integer $int.

Write a script to encrypt the string using the algorithm - for each character
$char in $str, replace $char with the $int th character after $char in the
alphabet, wrapping if needed and return the encrypted string.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub encryptedStr ($str,$int) {
  $int %= 26;
  my $a = ord('a'); 
  join '',map { chr($a + (ord($_) - $a + $int) % 26) } split //, $str;
}

is(encryptedStr('abc',1),'bcd','Example 1');
is(encryptedStr('xyz',2),'zab','Example 2');
is(encryptedStr('abc',27),'bcd','Example 3');
is(encryptedStr('hello',5),'mjqqt','Example 4');
is(encryptedStr('perl',26),'perl','Example 5');

done_testing;
