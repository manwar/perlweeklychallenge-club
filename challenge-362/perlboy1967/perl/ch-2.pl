#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-362#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Spellbound Sorting
Submitted by: Peter Campbell Smith

You are given an array of integers.

Write a script to return them in alphabetical order, in any language of your choosing. Default language is English.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use Lingua::EN::Numbers qw(num2en);
use Lingua::EN::Words2Nums qw(words2nums);

sub spellboundSorting (@ints) {
  map { words2nums($_) } sort map { num2en($_) } @ints;
}

is([spellboundSorting(6,7,8,9,10)],[8,9,7,6,10],'Example 1');
is([spellboundSorting(-3,0,1000,99)],[-3,99,1000,0],'Example 2');
is([spellboundSorting(1,2,3,4,5)],[5,4,1,3,2],'Example 3');
is([spellboundSorting(0,-1,-2,-3,-4)],[-4,-1,-3,-2,0],'Example 4');
is([spellboundSorting(100,101,102)],[100,101,102],'Example 5');

done_testing;
