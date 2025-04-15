#!/bin/perl

=pod

The Weekly Challenge - 317
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-317#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Friendly Strings
Submitted by: Mohammad Sajid Anwar

You are given two strings.

Write a script to return true if swapping any two letters in one string
match the other string, return false otherwise.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

use boolean;
use List::MoreUtils qw(zip6);

sub areFriendlyStrings ($str1,$str2) {
  my @l = grep { $$_[0] ne $$_[1] }
            zip6 @{[split //,$str1]},
                 @{[split //,$str2]};
  return boolean (
    scalar @l == 2 and 
    $l[0][0] eq $l[1][1] and 
    $l[0][1] eq $l[1][0]
  );
}

is(areFriendlyStrings('desc','dsec'),true,'Example 1');
is(areFriendlyStrings('fuck','fcuk'),true,'Example 2');
is(areFriendlyStrings('poo','eop'),false,'Example 3');
is(areFriendlyStrings('stripe','sprite'),true,'Example 4');
is(areFriendlyStrings('cater','cider'),false,'Own Example');


done_testing;
