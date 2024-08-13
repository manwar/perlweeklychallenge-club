#!/bin/perl

=pod

The Weekly Challenge - 282
- https://theweeklychallenge.org/blog/perl-weekly-challenge-282

Author: Niels 'PerlBoy' van Dijke

Task 2: Changing Keys
Submitted by: Mohammad Sajid Anwar

You are given an alphabetic string, $str, as typed by user.

Write a script to find the number of times user had to change the key to type
the given string. Changing key is defined as using a key different from the last
used key. The shift and caps lock keys won’t be counted.

=cut

use v5.32;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

sub changingKeys ($str) {
  $str =~ s#(?i)(.)\1#fc($1)#eg;
  $str =~ s#(.)\1+#$1#g;
  length($str) - 1;
}

is(changingKeys('pPeERrLl'),3,'Example 1');
is(changingKeys('rRr'),0,'Example 2');
is(changingKeys('GoO'),1,'Example 3');
is(changingKeys('Own__test'),7,'Own test');

done_testing;
