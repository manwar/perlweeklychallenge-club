#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( pair_diff(7,qw(10 8 12 15 5)), 1 );
is( pair_diff(6,qw(1 5 2 9 7)), 1 );
is( pair_diff(15,qw(10 30 20 50 40)), 0 );

done_testing();

sub pair_diff {
  my ($A,@N) = @_;
  while(@N) {
    my $l = shift @N;
    return 1 if grep { $_-$l == $A || $l-$_ == $A } @N;
  }
  return 0;
}

