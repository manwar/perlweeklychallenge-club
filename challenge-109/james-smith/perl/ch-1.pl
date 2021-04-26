#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese);

my @answer = qw(9999
  0  0  0  2  0  5  0  6  3  7
  0 15  0  9  8 14  0 20  0 21
);


is( chowla_map($_), $answer[ $_ ] ) foreach 1..20;
is( chowla_for($_), $answer[ $_ ] ) foreach 1..20;

done_testing();

## We will quickly run benchmarking...
## This suggests the for loop to be approximately 40%
## faster than the map solution...
## It is also 9 characters shorter...

cmpthese(1_000_000, {
  'Map' => sub { chowla_map($_) foreach 1..20; },
  'For' => sub { chowla_for($_) foreach 1..20; },
});

##
##        Rate  Map  For
## Map 59524/s   -- -26%
## For 79936/s  34%   --
##

## First attempt - the one-liner is to write this as a map,
## we add $t at the end which is the value returned
sub chowla_map {
  my ($t,$n) = (0,@_);
  ( map { (($n%$_) || ($t+=$_)) && () } 2..$n>>1 ), $t;
}


  ## This time we won't write this as a nasty map/reduce solution...
  ##
  ## Just a for loop;
  ##
  ## Notes:
  ##  * To allow for an "unless" in a postfix loop, we rewrite this
  ##    by noting:
  ##      unless( $condition ) { fun(); }
  ##    can be rewritten as:
  ##      ($condition)||($fun())
  ##  * in perl `foreach` and `for` are synonymous - so we can shorten
  ## Finally a quick "shortening" - if there is no specific return
  ## statement - we can just omit the return in the last statement...

sub chowla_for {
  my($t,$n)=(0,@_);
  ($n%$_)||($t+=$_) for 2..$n>>1;
  $t;
}

