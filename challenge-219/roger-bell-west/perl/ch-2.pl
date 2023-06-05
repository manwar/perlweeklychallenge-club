#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(travelexpenditure([2, 7, 25], [1, 5, 6, 7, 9, 15]), 11, 'example 1');
is(travelexpenditure([2, 7, 25], [1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31]), 20, 'example 2');

sub travelexpenditure($costs, $days0) {
  my @days = sort {$a <=> $b} @{$days0};
  my @validities = (1, 7, 30);
  my @stack;
  push @stack, {costdone => 0, daystodo => \@days};
  my $cheapest = (scalar @days) * $costs->[0];
  while (scalar @stack > 0) {
    my $c = shift @stack;
    if (scalar @{$c->{daystodo}} == 0) {
      if ($c->{costdone} < $cheapest) {
        $cheapest = $c->{costdone};
      }
    } else {
      if ($c->{costdone} >= $cheapest) {
        next;
      }
      my $start = $c->{daystodo}[0];
      foreach my $i (0..2) {
        my $ed = $start + $validities[$i] - 1;
        my @dtd = grep {$_ > $ed} @{$c->{daystodo}};
        push @stack,{costdone => $c->{costdone} + $costs->[$i],
                     daystodo => \@dtd};
      }
    }
  }
  return $cheapest;
}
