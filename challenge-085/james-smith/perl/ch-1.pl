#!/usr/local/bin/perl

use strict;
use warnings;
use Test::More;

is( trip_sum(qw(1.2 0.4 0.1 2.5)), 1 );
is( trip_sum(qw(0.2 1.5 0.9 1.1)), 0 );
is( trip_sum(qw(0.5 1.1 0.3 0.7)), 1 );

done_testing;

sub trip_sum {
  for my $i (0.. (@_-3) ) {
    next unless $_[$i] < 2;          ## For large arrays this might save some time...;
    for my $j ( ($i+1).. (@_-2) ) {
      next unless $_[$i]+$_[$j] < 2; ## For large arrays this might save some time...;
      for ( ($j+1) .. (@_-1) ) {
        return 1 if 1 < $_[$i]+$_[$j]+$_[$_] && $_[$i]+$_[$j]+$_[$_] < 2;
      }
    }
  }
  return 0;
}
