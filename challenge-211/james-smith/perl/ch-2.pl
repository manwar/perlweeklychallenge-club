#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ [1,2,3,4,5,6,7,8], 1 ],
  [ [1,3],             0 ],
);

sub equal_split {
  my( $t, $c ) = ( 0, scalar @_ );
  $t += $_ for @_;
  for my $x ( 1 .. ( 1 << $c-1 ) -1 ) {
    my($m,$n)=(0,0); my @T;
    ( $x & 1 ) && ( $m += $_[$_], $n++, push @T, $_[$_] ), $x >>= 1 for 1 .. $c-1;
    return 1 unless $n*$t-$m*$c;
  }
  0
}

is( equal_split( @{$_->[0]} ), $_->[1] ) for @TESTS;
