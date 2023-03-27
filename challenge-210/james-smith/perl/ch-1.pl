#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
 [ [2,3,1],        6 ],
 [ [1,1,2,2,2,3], 11 ],
);

sub kill_and_win {
  my($max,%v,$x)=0;
  $v{$_}++ for @_;                             ## Get freq in hash
  ( ( $x = ( $v{$_-1} ? $v{$_-1}*($_-1) : 0 )  ## Compute value
         + ( $v{$_  } ? $v{$_  }* $_    : 0 )  ## for current
         + ( $v{$_+1} ? $v{$_+1}*($_+1) : 0 )  ## integer
    ) > $max ) && ($max = $x) for keys %v;     ## if max reset max
  $max                                         ## return value
}

is( kill_and_win( @{$_->[0]} ), $_->[1] ) for @TESTS;
