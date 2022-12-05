#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);

my @TESTS = (
 ['?3:00',2,2],
 ['1?:00',9,9],
 ['2?:00',3,4],
 ['12:?5',5,5]
 ['12:5?',9,9]
);

is( digit_2359( $_->[0] ), $_->[1] ) for @TESTS;
is( digit_2400( $_->[0] ), $_->[2] ) for @TESTS;
done_testing();

sub digit_2359 {
  sub {
    $_[0] eq '?' ? ( $_[1]<4 ? 2 : 1 )
  : $_[1] eq '?' ? ( $_[0]<2 ? 9 : 3 )
  : $_[3] eq '?' ? 5
  :                9
  }->( split //, $_[0] );
}

sub digit_2400 {
  sub {
    $_[0] eq '?' ? ( $_[1]<4 ? 2 : $_[1]==4 && $_[3]==0 && $_[4]==0 ? 2 : 1 )
  : $_[1] eq '?' ? ( $_[0]<2 ? 9 :             $_[3]==0 && $_[4]==0 ? 4 : 3 )
  : $_[3] eq '?' ? 5
  :                9
  }->( split //, $_[0] );
}
