#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ ['12-01','20-01'], ['15-01','18-01'], 4 ] ,
  [ ['02-03','12-03'], ['13-03','14-03'], 0 ],
  [ ['02-03','12-03'], ['11-03','15-03'], 2 ],
  [ ['30-03','05-04'], ['28-03','02-04'], 4 ],
);

is( days_together($_->[0],$_->[1]), $_->[2] ) foreach @TESTS;

done_testing();

sub days_together {
  sub { $_[1]<$_[0] ? 0 : $_[1]-$_[0]+1 }->(
    sub { ( $_[2]>$_[0]?$_[2]:$_[0], $_[3]<$_[1]?$_[3]:$_[1] ) }->(
      map { [ 0,0,31,59,90,120,151,181,212,243,273,304,334 ]->[substr $_,3] + substr$_,0,2 }
      map { @{$_} }
      @_
    )
  )
}

