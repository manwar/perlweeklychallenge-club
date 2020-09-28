#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);

say candies( qw(1 2 2) );
say candies( qw(1 4 3 2) );

sub candies {
  my @ranks = @_;
  my $prev_count = @candies = map { 1 } @ranks; ## First pass we set everything to 1!
  my $flag;
  do {
    my $count = 0;
    foreach( 0..(@ranks-2) ) {         ## Loop through comparing element to next one - increase as approprite

      $candies[$_]   = $candies[$_+1]+1 if ($ranks[$_] > $ranks[$_+1]) && ($candies[$_] <= $candies[$_+1]);
      $candies[$_+1] = $candies[$_  ]+1 if ($ranks[$_] < $ranks[$_+1]) && ($candies[$_] => $candies[$_+1]);

      $count        += $candies[$_  ]; ## by the time we get here we would have done both comparisons that
                                       ## cause this entry to be updated..
    }

    $count += $candies[-1];            ## Add count for the last element...

    return $count if $count == $prev_count; ## Totals are the same so nothing been update can return
    $prev_count = $count;
  } while( 1 ); ## Infinite loop - will hit exit condition in loop...!
}
