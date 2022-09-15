#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [5, 2, 9, 1, 7, 6], 2 ],
  [ [4, 2, 3, 1, 5, 0], 4 ],
);

is( max_index(@{$_->[0]}), $_->[1] ) foreach @TESTS;

done_testing();

sub max_index {
  my $m=0;
  $_[$_]>$_[$m] && ($m=$_) for 0..$#_;
  $m;
}

