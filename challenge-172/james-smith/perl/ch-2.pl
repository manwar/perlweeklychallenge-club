#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @data_sets = (
 [0, 0, 1, 2, 63, 61, 27, 13],
 [1], [1,2], [1,2,3], [1,2,3,4], [1,2,3,4,5],
 [1,2,3,4,5,6], [1,2,3,4,5,6,7], [1,2,3,4,5,6,7,8],
 [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9,10],
);

foreach my $set ( @data_sets ) {
  say "Input: @{$set}";
  say '';
  say _dump( fivenum_avg(@{$set})   );
  say _dump( fivenum_mid(@{$set})   );
  say _dump( fivenum_range(@{$set}) );
  say '';
}

## Average - take the weighted average of the two value at either end of the
## "percentile" bracket..... Weight based on positional distance from point
sub fivenum_avg {
  my @sort = sort { $a <=> $b } @_;
  [
    map { $sort[$_->[0]] * (1 - $_->[1]) + ( $_->[1] ? $_->[1] * $sort[$_->[0]+1] : 0 ) }
    map { [ int $_, $_ - int $_ ] }
    map { $_/4*(@_-1) } 0..4
  ];
}

## Mid-point - take the average of the two values at either end of the
## "percentile" bracket.....
sub fivenum_mid {
  my @sort = sort { $a <=> $b } @_;
  [
    map { $_->[1] ? ($sort[$_->[0]] + $sort[$_->[0]+1])/2 : $sort[$_->[0]] }
    map { [ int $_, ($_ == int $_) ? 0 : 1 ] }
    map { $_/4*(@_-1) } 0..4
  ];
}

## If a value isn't cleanly defined - return the range in the form <v1-v2> to
## represent the abiguous nature of the median/quartile.
sub fivenum_range {
  my @sort = sort { $a <=> $b } @_;
  [
    map { $_->[1] ? '<'.$sort[$_->[0]].'-'.$sort[$_->[0]+1].'>' : $sort[$_->[0]] }
    map { [ int $_, ($_ == int $_) ? 0 : 1 ] }
    map { $_/4*(@_-1) } 0..4
  ];
}

sub _dump {
  '  '.join ' ',map { sprintf '%10s', $_ } @{$_[0]};
}
