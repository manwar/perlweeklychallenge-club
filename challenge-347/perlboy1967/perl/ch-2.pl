#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-347#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Format Phone Number
Submitted by: Mohammad Sajid Anwar

You are given a phone number as a string containing digits, space and dash only.

Write a script to format the given phone number using the below rules:

1. Removing all spaces and dashes
2. Grouping digits into blocks of length 3 from left to right
3. Handling the final digits (4 or fewer) specially:
- 2 digits: one block of length 2
- 3 digits: one block of length 3
- 4 digits: two blocks of length 2
4. Joining all blocks with dashes

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub formatPhoneNumber ($str) {
  $str =~ s/\D+//g;

  # Split the string in three character substrings
  my @p = unpack('(A3)*',$str);

  # The remainder is in $p[-1]
  # Length is either one or two. 
  # Two is okay, one needs 'borrowing at $p[-2]
  if (length $p[-1] == 1) {
    push(@p,unpack('(A2)*',join('',reverse(pop(@p),pop(@p))));
  }

  return join('-',@p);
}

is(formatPhoneNumber('1-23-45-6'),'123-456','Example 1');
is(formatPhoneNumber('1234'),'12-34','Example 2');
is(formatPhoneNumber('12 345-6789'),'123-456-789','Example 3');
is(formatPhoneNumber('123 4567'),'123-45-67','Example 4');
is(formatPhoneNumber('123 456-78'),'123-456-78','Example 5');

done_testing;
