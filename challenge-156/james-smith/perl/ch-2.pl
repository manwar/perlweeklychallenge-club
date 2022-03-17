#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 12,   0 ], [ 70,   1 ], [ 836,  1 ], [ 840,  0 ],
  [ 4030, 1 ], [ 4032, 0 ], [ 5830, 1 ], [ 5832, 0 ],
);

is( is_weird($_->[0]), $_->[1] ) for @TESTS;

done_testing();
is_weird($_) && say for 1..5000;

sub is_weird {
  my($s,$n) = (0,shift);

  $s+=$_ for my @fact = (1,map { $n%$_ ? () : ( $_, $_*$_==$n ? () : $n/$_ ) } 2..sqrt($n));

  return 0 if $s <= $n; ## Not weird... as sum of factors <= $n

  for my $ind ( 0..(1<<@fact)-1 ) {
    my $t = -$n;
    $ind ? ($ind & 1 && ($t+=$fact[$_]) ) : last, $ind>>=1 for 0..$#fact;
    return 0 unless $t; ## Not weird as sum of factors is 0...
  }

  return 1;             ## Weird
}
