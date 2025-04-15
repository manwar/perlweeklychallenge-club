#!/bin/perl

=pod

The Weekly Challenge - 317
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-317#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Acronyms
Submitted by: Mohammad Sajid Anwar

You are given an array of words and a word.

Write a script to return true if concatenating the first letter of each
word in the given array matches the given word, return false otherwise.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);
 
use boolean;
use List::MoreUtils qw(all zip6);

sub isAcronym ($acronym,@words) {
  boolean all { fc(substr($$_[0] // '',0,1)) eq fc($$_[1] // '') } 
                zip6 @words, @{[split(//,$acronym)]}
}

is(isAcronym('PWC',qw(Perl Weekly Challenge)),true,'Example 1');
is(isAcronym('BCJ',qw(Bob Charlie Joe)),true,'Example 2');
is(isAcronym('MM',qw(Morning Good)),false,'Example 3');
is(isAcronym('ABC',qw(Alpha Bravo Charlie Delta)),false,'Own Example 1');
is(isAcronym('ABCD',qw(Alpha Bravo Charlie)),false,'Own Example 2');

done_testing;
