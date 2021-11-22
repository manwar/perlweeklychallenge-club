#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [2,3,1], 1 ],
  [ [2,3,2], 2 ],
  [ [2,3,3], 2 ],
  [ [2,3,4], 3 ],
  [ [2,3,5], 4 ],
  [ [2,3,6], 6 ],
  [ [3,3,6], 4 ],
);

is( get_num(@{$_->[0]}), $_->[1] ) foreach @TESTS;

done_testing();

sub get_num {
  my($i,$j,$k,%h) = @_;
  $a=$_, map { $h{$a*$_}++ } 1..$j for 1..$i;
  $k-=$h{$_}, ($k<1) && (return $_) for sort { $a<=>$b } keys %h;
}

