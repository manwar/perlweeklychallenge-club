#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( 1*nth_root(5,248832),12);
is( 1*nth_root(5,34),    2.02439746);

done_testing();

sub nth_root {
  my( $n, $k ) = @_;
  sub pow {
    my $res = 1;
    $res *= $_[0] foreach 1..$_[1];
    return $res;
  }
  ## Not going to use any of the high level maths here as
  ## We could easily write this as $k**(1/$n);

  ## We will use a simple binary search - where we start with
  ## two values "l" and "r";
  ## and each time cut the region in 2. Which ever half "k" is
  ## in we move either "l" or "r" to the mid value and repeat

  my $l = 0;

  ## Tweak to quickly chose a better r...
  ## If k has less than n digits it can't be greater than 10
  ## If k has less than 2n digits it can't be greater than 100
  ## .... So we can optimize the value of r - to speed things
  ## up slightly...

  my $r = '1'.'0'x (1+ int(length(int $k)/$n) );
     $r = $k if $r>$k;

  my $m; # This is the midpoint...
  my($ln,$rn) = (1, pow($r,$n));

  ## Table of savings....
  ##    r #steps (for n=5)  #steps without opt delta saving
  ##   10     37 k < 100_000                50    13    35%
  ##  100     40 k < 10_000_000_000         67    27    40%
  ## 1000     44 k < 1_000_000_000_000_000  84    40    48%

  while( $r-$l > 1e-10) { ## Repeat until the interval is small
    my $mn = pow($m = ($r+$l)/2,$n);
    if($mn<$k) {
      ($l,$ln) = ($m,$mn);
      next;
    }
    ($r,$rn) = ($m,$mn);
  }
  return sprintf '%0.8f',$m;
}

