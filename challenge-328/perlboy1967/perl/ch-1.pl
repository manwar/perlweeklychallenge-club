#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-328#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Replace all ?
Submitted by: Mohammad Sajid Anwar

You are given a string containing only lower case English letters and ?.

Write a script to replace all ? in the given string so that the string 
doesn’t contain consecutive repeating characters.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub replaceAllQuestionMarks ($str) {
  sub _rep {
    my @c = map { $_ // '' } @_;
    $c[0].(grep !/[$c[0]$c[1]]/,'a'..'c')[0].$c[1];
  }
  1 while ($str =~ s/(.)?\?(.)?/_rep($1,$2,$3)/e);
  return $str;
}

is(replaceAllQuestionMarks('a?z'),'abz','Example 1');
is(replaceAllQuestionMarks('pe?k'),'peak','Example 2');
is(replaceAllQuestionMarks('gra?te'),'grabte','Example 3');
is(replaceAllQuestionMarks('ab??f??i'),'ababfabi','Own example 1');
is(replaceAllQuestionMarks('a?b?c?a?'),'acbacbab','Own example 2');

done_testing;
