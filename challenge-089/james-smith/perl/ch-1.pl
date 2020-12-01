#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( gcd_sum(1),   0 );
is( gcd_sum(2),   1 );
is( gcd_sum(3),   3 );
is( gcd_sum(4),   7 );
is( gcd_sum(5),  11 );
is( gcd_sum(6),  20 );
is( gcd_sum(7),  26 );
is( gcd_sum(8),  38 );
is( gcd_sum(9),  50 );
is( gcd_sum(10), 67 );

done_testing();

sub gcd_sum {
  my $n = shift;
  my $sum = 2*$n-2; ### We can pull out the GCDs with 1 as either side
                    ### Note because of the optimization below we only
                    ### Remove -2 as we remove another one is the
                    ### special case where $x==2;
  foreach my $x ( 2..$n ) {
    ## Note that the gcd is symetric gcd($m,$n) == gcd($m,$m-$n) where $n between 1 & $m-1
    $sum += 2*gcd( $x, $_ ) foreach 2..$x/2;
    ## We have counted the middle value twice if $x is even.... so remove one of them...
    $sum -= $x/2 unless $x%2;
  }
  return $sum;
}

sub gcd {
  my( $n,$m ) = @_;
  ## The way we have set up gcd sum we know $n>$m in all cases
  ## So don't need to check m will always be <= n
  ($n,$m) = ( $m, $n % $m ) while $n % $m;
  return $m;
}
