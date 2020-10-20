#!/usr/local/bin/perl

use strict;
use warnings;

use Test::More;

is( flip_array( 3,10,8 ),    1 );
is( flip_array( 12, 2, 10 ), 1 );
is( flip_array( 1..20 ),     6 );

done_testing;

## Let's avoid recursion as this is inefficient...
## We will try and do this with a minimum of variables
## We effectively do binary increment on the elements of the array
## Flipping from +ve -> -ve is like flipping from 0 -> 1
## So if we flip from -ve -> +ve we need to flip the next bit or number

sub flip_array {
  my @array = @_;
  my $sum = 0;
     $sum+=$_ foreach @array; ## Initial "unflipped" sum...
  my( $flipped, $smallest, $best, $na ) = ( 0, $sum, 0, scalar @array ); ## Initialise counts/running sums...

  while(1) {
    ($best,$smallest)=($flipped,$sum) if $sum>=0 && $sum < $smallest || $sum == $smallest && $flipped < $best;
    foreach(0..$na) {
      return $best if $_ == $na;          ## Now reached the end as we have flipped the last element back...
      $sum += 2*($array[$_]=-$array[$_]); ## Flip bit and update sum...
      if( $array[$_]> 0 ) {               ## We carry over to the next bit (if the element has been flipped back)
        $flipped --;
      } else {                            ## No need to carry so finish loop...
        $flipped ++;
        last;
      }
    }
  }
}
