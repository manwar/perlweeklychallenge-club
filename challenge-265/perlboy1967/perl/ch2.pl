#!/bin/perl

=pod

The Weekly Challenge - 265
- https://theweeklychallenge.org/blog/perl-weekly-challenge-265

Author: Niels 'PerlBoy' van Dijke

Task 2: Completing Word
Submitted by: Mohammad Sajid Anwar

You are given a string, $str containing alphnumeric characters and array of strings 
(alphabetic characters only), @str.

Write a script to find the shortest completing word. If none found return empty string.

|| A completing word is a word that contains all the letters in the given string,
|| ignoring space and number. If a letter appeared more than once in the given string
|| then it must appear the same number or more in the word.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::AllUtils qw(all);

sub completingWord ($str,$ar) {
  sub sFreq ($s) {
    my %sF; $sF{lc $_}++ for (grep /[a-zA-Z]/, split //, $s);
    return %sF;
  }
 
  my %sFreq = sFreq($str);

  (sort { length($a) <=> length($b) || $a cmp $b } 
     grep { 
       my %f = sFreq($_);
        all { exists $f{$_} and $sFreq{$_} <= $f{$_} } keys %sFreq;
     } @$ar)[0];
}

is([completingWord('aBc 11c',['accbbb','abc','abbc'])],['accbbb'],'Example 1');
is([completingWord('Da2 abc',['abcm','baacd','abaadc'])],['baacd'],'Example 2');
is([completingWord('JB 007',['jj','bb','bjb'])],['bjb'],'Example 3');

done_testing;
