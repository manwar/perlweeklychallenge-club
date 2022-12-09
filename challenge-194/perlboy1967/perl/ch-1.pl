#!/bin/perl

=pod

The Weekly Challenge - 194
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-194/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Digital Clock
Submitted by: Mohammad S Anwar

You are given time in the format hh:mm with one missing digit.

Write a script to find the highest digit between 0-9 that makes it valid time.

=cut

use v5.16;
use warnings;

use Test::More;


sub highestDigit ($) {
  if ($_[0] !~ m#^[\d\?][\d\?]:[\d\?][\d\?]$# or 
     ($_[0] =~ y/?/?/) != 1) {
    return -1;
  } else {
    my $i = index($_[0],'?');
    if (0) { } # Do nothing, just look pretty in code 
    elsif ($i == 0) { return substr($_[0],1,1) < 4 ? 2 : 1 }
    elsif ($i == 1) { return substr($_[0],0,1) < 2 ? 9 : 3 }
    elsif ($i == 2) { return -1 }
    elsif ($i == 3) { return  5 }
    elsif ($i == 4) { return  9 }
  }
}

my %t = qw(
  ?5:00   1  ?3:00  2  1?:00  9  2?:00  3  12:?5  5  12:5?  9
  00?00  -1  ??:00 -1  00:?? -1  0?:?0 -1  ?0:0? -1  ????? -1
 ?00:00  -1 ???:00 -1 00??00 -1 00??00 -1 00:??0 -1 0?:00? -1  
);

for (sort keys %t) {
 is(highestDigit($_),$t{$_},"highestDigit('$_')");
}

done_testing;
