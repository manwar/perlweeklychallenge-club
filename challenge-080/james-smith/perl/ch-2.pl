#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);

use Test::More;

is( candies( qw(1 2 2) ),          4 );
is( candies( qw(1 4 3 2) ),        7 );
is( candies( qw(5 4 3 2 1) ),     15 );
is( candies( qw(5 4 3 4 3 2 1) ), 16 );
is( candies( qw(2 1 2 1 2 1 2) ), 11 );

done_testing;

sub candies {
  my @ranks = @_;
  my $prev_count = my @candies = map { 1 } @ranks; ## First pass we set everything to 1!
  my $flag;
  ## Sweep left first...
  foreach( 0..(@ranks-2) ) {
    $candies[$_+1] = $candies[$_]+1 if $ranks[$_] < $ranks[$_+1] && $candies[$_] >= $candies[$_+1];
  }
  ## Then sweep right... we have to go right to left otherwise you don't get the right answer
  ## at the end...
  foreach( reverse 1..(@ranks-1) ) {
    $candies[$_-1] = $candies[$_]+1 if $ranks[$_] < $ranks[$_-1] && $candies[$_] >= $candies[$_-1];
  }
  my $t = 0;
  $t+= $_ foreach @candies;
  return $t;
}
