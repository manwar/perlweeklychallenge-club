#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [ [1,4], [3,5], [6,8], [12, 13], [3,20] ],  '[ (3,5), (3,20) ]' ],
  [ [ [3,4], [5,7], [6,9], [10, 12], [13,15] ], '[ (6,9) ]'         ]
);

is( print_res( conflict_intervals( $_->[0] ) ), $_->[1] ) foreach @TESTS;
is( print_res( conflict_intervals_compact( $_->[0] ) ), $_->[1] ) foreach @TESTS;
done_testing();

say print_res( conflict_intervals(         $_->[0] ) ) foreach @TESTS;
say print_res( conflict_intervals_compact( $_->[0] ) ) foreach @TESTS;

sub print_res {
  return sprintf '[ %s ]', join ', ', map { "($_->[0],$_->[1])" } @{$_[0]};
}

sub conflict_intervals {
  my @in = @{ $_[0] };
  my @out;
  while( my $int = pop @in ) {
    foreach(@in) {
      next unless $int->[1] < $_->[0] || $int->[0] < $_->[1];
      unshift @out, $int;
      last;
    }
  }
  return \@out;
}

sub conflict_intervals_compact {
  my(@i,@o) = @{$_[0]};
  while(my $r = pop @i) {
    ($r->[1] < $_->[0] || $r->[0] < $_->[1]) && (unshift @o, $r) && last foreach @i;
  }
  return \@o;
}

