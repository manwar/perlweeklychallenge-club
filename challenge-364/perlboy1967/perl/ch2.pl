#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-364#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Goal Parser
Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a script to interpret the given string using Goal Parser.

||  The Goal Parser interprets “G” as the string “G”, “()” as the string “o”,
||  and “(al)” as the string “al”. The interpreted strings are then concatenated
||  in the original order.


=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub goalParser ($str) {
  my $m //= {'()' => 'o', '(al)' => 'al' };
  $str =~ s#(\(\)|\(al\))#$m->{$1}#gr;
}

is(goalParser('G()(al)'),'Goal','Example 1');
is(goalParser('G()()()()(al)'),'Gooooal','Example 2');
is(goalParser('(al)G(al)()()'),'alGaloo','Example 3');
is(goalParser('()G()G'),'oGoG','Example 4');
is(goalParser('(al)(al)G()()'),'alalGoo','Example 5');

done_testing;
