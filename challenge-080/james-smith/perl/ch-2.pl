#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);

use Test::More;

is( candies( qw(1 2 2) ),          4 );
is( candies( qw(1 4 3 2) ),        7 );
is( candies( qw(5 4 3 2 1) ),     15 );
is( candies( qw(2 1 2 1 2 1 2) ), 11 );

done_testing;

sub candies {
  my @ranks = @_;
  my $prev_count = my @candies = map { 1 } @ranks; ## First pass we set everything to 1!
  my $flag;
  do {
    my $count = 0;
    foreach( 0..(@ranks-2) ) {         ## Loop through comparing element to next one - increase as approprite
      $candies[$_+1] = $candies[$_  ]+1 if $ranks[$_] < $ranks[$_+1] && $candies[$_] >= $candies[$_+1];
      $candies[$_]   = $candies[$_+1]+1 if $ranks[$_] > $ranks[$_+1] && $candies[$_] <= $candies[$_+1];
      $count        += $candies[$_  ]; ## by the time we get here we would have done both comparisons that
                                       ## cause this entry to be updated..
    }

    $count += $candies[-1];            ## Add count for the last element...

    return $count if $count == $prev_count; ## Totals are the same so nothing been update can return
    $prev_count = $count;
  } while( 1 ); ## Infinite loop - will hit exit condition in loop...!
}
