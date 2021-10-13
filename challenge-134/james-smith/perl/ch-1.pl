#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $S = 10;
my @s = (1,0,2..$S-1); ## Cheat we jump into the first pemutation which
                       ## doesn't start with a "0" 1023456789 - avoids
                       ## us having to check for a leading 0...
my $count=5;

do {
  say @s;
} while next_perm && --$count;


sub next_perm {
  my($i,$j,$p);
  ## Find largest index for which Si+1 > Si
  ( $s[$_] < $s[$_+1] ) && ( $i=$_ ) foreach 0 .. $S-2;    ## Find i

  return unless defined $i; ## Got to the end of the list of permutations

  ## Find latest index for which Sj > Si for j>i
  ( $s[$i] < $s[$_]   ) && ( $j=$_ ) foreach $i+1 .. $S-1; ## Find j

  ## Flip i & jth elements..., then all numbers greater than i..
  ( $s[$i], $s[$j] ) = ( $s[$j], $s[$i] );               ## Flip numbers over...
  @s[ $i+1 .. $S-1 ] = @s[ reverse $i+1 .. $S-1 ];       ## Flip remaining list
  return 1;
}

