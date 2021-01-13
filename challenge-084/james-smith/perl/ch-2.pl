#!/usr/local/bin/perl

use strict;
use warnings;
use Test::More;

is( squares([ [qw(0 1 0 1)], [qw(0 0 1 0)], [qw(1 1 0 1)], [qw(1 0 0 1)], ]), 1 );
is( squares([ [qw(1 1 0 1)], [qw(1 1 0 0)], [qw(0 1 1 1)], [qw(1 0 1 1)], ]), 4 );
is( squares([ [qw(0 1 0 1)], [qw(1 0 1 0)], [qw(0 1 0 0)], [qw(1 0 0 1)], ]), 0 );

done_testing;

sub squares {
  my $grid = shift @_;
  my $m  = @{$grid};
  my $n  = @{$grid->[0]};
  my $ms = $m < $n ? $m : $n;
  my $count = 0;
  for my $s (1..($ms-1)) {
    foreach my $i (0..($m-$s-1)) {
      foreach my $j (0..($n-$s-1)) {
        $count+= $grid->[$i][$j]
               * $grid->[$i+$s][$j]
               * $grid->[$i][$j+$s]
               * $grid->[$i+$s][$j+$s];
      }
    }
  }
  return $count;
}
