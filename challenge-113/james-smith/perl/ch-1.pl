#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( represent( 25,  8), 0 );
is( represent( 25,  7), 0 );
is( represent( 24,  7), 1 );
is( represent( 24,  0), 0 );
is( represent( 10,  0), 1 );
is( represent( 28,  8), 1 );
is( represent( 26,  8), 1 );
is( represent( 16,  8), 0 );
is( represent( 441, 9), 1 );
is( represent( 431, 9), 0 );
done_testing();

sub represent {
  my( $n, $d ) = @_;
  ## Get the smallest number when multipled by $d
  ## that would have the same last digit as $m...
  ## or undef if there is no such digit {happens
  ## when $d is in 0,2,5 and the last digit is
  ## not 0, even or 5/0 respectively...

  my ($k) = grep { ($_*$d)%10 == $n%10 } 0..9;

  ## If $k is defined we still need to check to
  ## see if $n is large enough for $k distinct
  ## numbers to add up to it..
  ##
  ## In this case
  ##    $n >= $d + 1$d + 2$d .. ($k-1)$d
  ## or $n >= $d$k + 10 (0 + 1 + 2 + ... $k-1);
  ## or $n >= $d$k + 10 * $k * ($k-1)/2;
  ##    $n >= $k ( $d + 5 * $k - 5 );

  return defined $k && $n >= $k*(5*$k-5+$d) ? 1 : 0
}

