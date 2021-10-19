#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @s = reverse 1..9,0; ## Cheat we start with the last perumation
                        ## starting with 0 - 0987654321
                        ## Saves us looping through the first
                        ## combinations checking for number starting
                        ## with non-zero (362880 combinations)
my $count = @ARGV ? $ARGV[0] : 5;

sub next_perm {
  my( $i, $j );

  ## Find largest index for which Si+1 > Si
  ( $s[$_] < $s[$_+1] ) && ( $i = $_ ) foreach 0 .. @s-2;    ## Find i

  return unless defined $i; ## Got to the end of the list of permutations

  ## Find latest index for which Sj > Si for j>i
  ( $s[$i] < $s[$_]   ) && ( $j = $_ ) foreach $i+1 .. @s-1; ## Find j

  ## Flip ith & jth elements..., then all numbers greater than i..
  @s[ $i, $j       ] = @s[ $j, $i               ];
  @s[ $i+1 .. @s-1 ] = @s[ reverse $i+1 .. @s-1 ];

  return 1; ## Return true to say can continue...
}

say @s while next_perm && $count--;

