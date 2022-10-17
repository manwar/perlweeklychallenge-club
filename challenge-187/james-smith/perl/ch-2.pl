#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [1,2,3,2], '3 2 2' ],
  [ [1,3,2],   '' ],
  [ [1,1,2,3], '' ],
  [ [2,4,3],   '4 3 2' ],
);

is( "@{[magical(@{$_->[0]})]}", $_->[1] ) foreach @TESTS;

done_testing();

sub magical {
  @_ = sort { $b<=>$a } @_;
  my @max = (0);
  while(@_>2) {
    my($a,$b,@c)=@_;
    while(@c) {
      ($a+$b>$_) && ($b+$_>$a) && ($a+$_>$b) && ($a+$b+$_>$max[0]) && (@max=($a+$b+$_,$a,$b,$_)) for @c;
      $b = shift @c;
    }
    shift;
  }
  shift @max;
  @max;
}

