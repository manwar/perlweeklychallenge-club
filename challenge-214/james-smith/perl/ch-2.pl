#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ [2,4,3,3,3,4,5,4,2], 23 ],
  [ [1,2,2,2,2,1], 20 ],
  [ [1], 1 ],
  [ [2,2,2,1,1,2,2,2], 40 ],
  [ [2,1,2,1,2,1,2,1,2,1,2,1,2,1,2], 1 ],
);

sub collect {
  return 0 unless @_;
  my $m = 0;
  for ( my $e = my $o = 0; $o<@_; ) {
    my $e = $o;
    $e++ while $_[$o]==$_[$e];
    sub { $m=$_[0] if $m<$_[0] }->(
      ($e-$o)**2 +
      collect( @_[ 0..$o-1, $e..$#_ ] )
    );
    $o = $e
  }
  $m
}

is( collect( @{$_->[0]} ), $_->[1] ) for @TESTS;
done_testing();
