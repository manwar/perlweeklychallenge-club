#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-369#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Group Division
Submitted by: Mohammad Sajid Anwar

You are given a string, group size and filler character.

Write a script to divide the string into groups of given size. In the last group
if the string doesn’t have enough characters remaining fill with the given filler
character.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub groupDevision ($str,$size,$filler) {
  unpack("(a$size)*",
         $str . (length($str) % $size ? 
                 $filler x ($size - (length($str) % $size)) :
                 '')
        );
}

is([groupDevision('RakuPerl',4,'*')],['Raku','Perl'],'Example 1');
is([groupDevision('Python',5,'0')],['Pytho','n0000'],'Example 2');
is([groupDevision('12345',3,'x')],['123','45x'],'Example 3');
is([groupDevision('HelloWorld',3,'_')],['Hel','loW','orl','d__'],'Example 4');
is([groupDevision('AI',5,'!')],['AI!!!'],'Example 5');

done_testing;
