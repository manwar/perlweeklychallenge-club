#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-352#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Match String
Submitted by: Mohammad Sajid Anwar
You are given an array of strings.

Write a script to return all strings that are a substring of another word
in the given array in the order they occur.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::MoreUtils qw(uniq any);

sub matchString (@words) {
  uniq grep {
    my $word = $_;
    any { length($_) > length($word) and index($_,$word) > -1 } @words;
  } @words;
}


is([matchString(qw{cat cats dog dogcat dogcat rat ratcatdogcat})],
   [qw{cat dog dogcat rat}],'Example 1');
is([matchString(qw{hello hell world wor ellow elloworld})],
   [qw{hell world wor ellow}],'Example 2');
is([matchString(qw{a aa aaa aaaa})],
   [qw{a aa aaa}],'Example 3');
is([matchString(qw{flower flow flight fl fli ig ght})],
   [qw{flow fl fli ig ght}],'Example 4');
is([matchString(qw{car carpet carpenter pet enter pen pent})],
   [qw{car pet enter pen pent}],'Example 5');

done_testing;
