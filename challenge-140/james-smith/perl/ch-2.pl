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
is( get_num_exp(@{$_->[0]}), $_->[1] ) foreach @TESTS;

done_testing();

sub get_num {
  my($i,$j,$k,$t,%h) = @_;
  $t=$_, map { $h{$t*$_}++ } 1..$j for 1..$i;
  $k-=$h{$_}, ($k<1) && (return $_) for sort { $a<=>$b } keys %h;
}

sub get_num_exp {
  my($i,$j,$k,$t,%h) = @_;
  foreach $t (1..$i) {
    $h{$t*$_}++ foreach 1..$j;
  }
  for (sort {$a<=>$b} keys %h) {
    $k -= $h{$_};
    return $_ if $k<1;
  }
}
