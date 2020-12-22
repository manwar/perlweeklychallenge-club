#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( iso('abc','xyz'), 1 );
is( iso('abb','xyy'), 1 );
is( iso('sum','add'), 0 );
is( iso('add','sum'), 0 );

done_testing( );

sub iso {
  ## This one needs a bit of explanation....
  ## We are going to normalise the strings - by replacing first chr
  ## and all its subsequent occurances with 'a', 2nd (different) character
  ## with 'b' .....
  ## so above examples we get...
  ##   abc -> abc   xyz -> abc
  ##   abb -> abb   xyy -> abb
  ##   sum -> abc   add -> abb
  ##   add -> abc   sum -> abc

  my ($a,$b) = map {
    ## Initialise letter cache and "counter"
    my ($x,%m)='a';
    join '',                ## Stitch back the word and return it....
      map { $m{$_}||=$x++ } ## Return letter from cache (or next letter)
      split m{}, $_         ## Split into individual characters
  } @_;
  return $a eq $b ? 1 : 0;  ## Check to see if generated words are isomorphic
}

