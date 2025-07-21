#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-330#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Title Capital
Submitted by: Mohammad Sajid Anwar

You are given a string made up of one or more words separated by a single space.

Write a script to capitalise the given title. If the word length is 1 or 2 then convert
the word to lowercase otherwise make the first character uppercase and remaining lowercase.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub titleCapital ($str) {
  join ' ',map { length($_) <= 2 ? $_ : ucfirst } split /\s+/,lc $str;
}

is(titleCapital('PERL IS gREAT'),'Perl is Great','Example 1');
is(titleCapital('THE weekly challenge'),'The Weekly Challenge','Example 2');
is(titleCapital('YoU ARE A stAR'),'You Are a Star','Example 3');

done_testing;
