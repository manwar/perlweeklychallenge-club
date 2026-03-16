#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-360#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Text Justifier
Submitted by: Mohammad Sajid Anwar

You are given a string and a width.

Write a script to return the string that centers the text within that width using asterisks * as padding.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub textJustifier ($str,$width) {
  my $padLength = int(($width - length($str)) / 2);
  return sprintf('%s%s%s',
                 '*' x $padLength,
                 $str,
                 '*' x ($width - length($str) - $padLength));
}

is(textJustifier('Hi',5),'*Hi**','Example 1');
is(textJustifier('Code',10),'***Code***','Example 2');
is(textJustifier('Hello',9),'**Hello**','Example 3');
is(textJustifier('Perl',4),'Perl','Example 4');
is(textJustifier('A',7),'***A***','Example 5');

done_testing;
