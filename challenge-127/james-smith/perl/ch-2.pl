#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [1,4], [3,5], [6,8], [12, 13], [3,20] ],
  [ [3,4], [5,7], [6,9], [10, 12], [13,15] ],
);

#is( my_function($_->[0]), $_->[1] ) foreach @TESTS;
#done_testing();

print_res( conflict_intervals( $_ ) ) foreach @TESTS;
print_res( conflict_intervals_compact( $_ ) ) foreach @TESTS;

sub print_res {
  printf "[ %s ]\n", join ', ', map { "($_->[0],$_->[1])" } @{$_[0]};
}

sub conflict_intervals {
  my @in = @{ $_[0] };
  my @conf;
  while( my $int = pop @in ) {
    foreach(@in) {
      next unless $int->[1] < $_->[0] || $int->[0] < $_->[1];
      unshift @conf, $int;
      last;
    }
  }
  return \@conf;
}

sub conflict_intervals_compact {
  my(@in,@conf) = @{$_[0]};
  while(my $int = pop @in) {
    ($int->[1] < $_->[0] || $int->[0] < $_->[1]) && (unshift @conf, $int) && last foreach @in;
  }
  return \@conf;
}

