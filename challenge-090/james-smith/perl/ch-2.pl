#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

## This is ripe for bit operators - as it is about multiplying/diving by 2...
## and checking for the value of the "1s" bit....
#
# To execute as a quiet test - use `perl ch-2.pl`
#
# To show workings run `perl ch-2.pl 1`

my $flag = @ARGV && $ARGV[0] eq '1' ? 1 : 0;
foreach(1..10) {
  my $x = 100 + int rand(400);
  my $y = 100 + int rand(400);
  is( eth_mult( $x , $y, $flag ), $x*$y );
}

done_testing();

sub eth_mult {
  my( $n, $m, $verbose ) = @_;
  $verbose ||= 0;
  my $calc = $n*$m;
  my $res = 0;
  say q() if $verbose;
  while($n) {
    printf "%7d x %7d | %7s\n", $n, $m, $n&1 ? $m : q(.) if $verbose;
    # The meat - use binary and
    $res += $m if $n&1;
    $m<<=1;
    $n>>=1;
  }
  if( $verbose ) {
    say    q(------------------+--------);
    printf "                  | %7d (%7d)\n", $res, $calc;
    say q();
  }
  return $res;
}

