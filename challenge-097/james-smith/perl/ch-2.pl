#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( min_flips('101101',3), 0 );
is( min_flips('101100101',3), 1 );
is( min_flips('10110111', 4), 2 );
is( min_flips('100101100',3), 1 );
is( min_flips('101100100100101',3), 2 );
is( min_flips('0000000100100011010001010110011110001001101010111100110111101111',4), 32 );

done_testing();

sub min_flips {
  ## Golf mode on...
  ##
  ## This was to use this to serve as an example of perl idioms that other programmers
  ## may find it difficult to understand - and so I tried to put as many of them in relatively
  ## short function....
  ##
  ## One statement functions are a lovely perl concept - even if they can get a bit difficult
  ## to read....
  ##

  local $/;
  return [
    map {
      local $\ = ( $_[0] ^ (substr$_[0],$_,$_[1]) x (length($_[0])/$_[1]) ) =~ tr/\x01/\x01/,
      $/ = (!$_ || ($\ < $/)) ? $\ : $/
    }
    map { $_*$_[1] }
    0 .. ( length($_[0])/$_[1] - 1 )
  ]->[-1];
  ## We could use variales here - but playing with localised special variables is fun!
  ## $/ <- minimum value
  ## $\ <- value for given chunk....
  ##
  ## The inner map + range combination returns a list of ids of the form 0, $n, 2*$n until the
  ## end of the array, we use this to chunk the array up for comparison
  ##
  ## Inside the end map - we first string "xor" the string with the repeated chunk of the array.
  ## so e.g. for the first example this becomes:
  ##   '101100101' ^ '101'.'101'.'101'
  ##   '101100101' ^ '100'.'100'.'100'
  ##   '101100101' ^ '101'.'101'.'101'
  ## if the symbols match you get a value \x00, when they don't match you get value \x01
  ## so we then count the \x01's using tr... and store in $\
  ##
  ## Next if it is the first chunk OR the value of $\ is less than the current min ($/)
  ## We set $/ to $\ otherwise we leave it as $/
  ##
  ## The resulting array consists of the value for the node and the running minimum in the examples
  ##
  ## for ex 1: it is [0,0,0,0]
  ## for ex 2: it is [1,1,2,1,1,1]
  ## for ex 3: it is [1,1,1,1]
  ## for ex 4: it is [2,2,2,2]
  ## for ex 5: it is [2,2,1,1,1,1]
  ##
  ## We need the last value of this so we wrap the list into an array ref and take the last element
  ##
  ## [ list... ]->[-1];
}

