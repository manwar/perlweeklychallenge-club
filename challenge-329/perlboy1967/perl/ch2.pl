#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-329#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Nice String
Submitted by: Mohammad Sajid Anwar

You are given a string made up of lower and upper case English letters only.

Write a script to return the longest substring of the give string which is
nice. A string is nice if, for every letter of the alphabet that the string
contains, it appears both in uppercase and lowercase.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(max);

sub maxNiceStrings ($str) {
  my @s; push(@s,$1) while ($str =~ /(([a-zA-Z])\2+)/ig);
  my @n = grep { /[a-z]/ and /[A-Z]/ } @s;
  my $maxLen = max(map { length } @n) // 0;
  $maxLen ? grep { $maxLen == length } @n : ();
}

is([maxNiceStrings('YaaAho')],  ['aaA'],      'Example 1');
is([maxNiceStrings('cC')],      ['cC'],       'Example 2');
is([maxNiceStrings('A')],       [],           'Example 3');
is([maxNiceStrings('YaaaHoO')], ['oO'],       'Own Example 1');
is([maxNiceStrings('YaAaHooO')],['aAa','ooO'],'Own Example 2');

done_testing;
