#!/bin/perl

=pod

The Weekly Challenge - 213
- https://theweeklychallenge.org/blog/perl-weekly-challenge-213

Author: Niels 'PerlBoy' van Dijke

Task 2: Shortest Route
Submitted by: Mohammad S Anwar

You are given a list of bidirectional routes defining a network of nodes, as well
as source and destination node numbers.

Write a script to find the route from source to destination that passes through 
fewest nodes.

=cut

use v5.16;

use common::sense;

use Paths::Graph;
use List::MoreUtils qw(slide);

use Test::More;
use Test::Deep qw(cmp_deeply);

sub shortestRoute ($$\@) {
  my ($o,$d,$ar) = @_;
  my %g;

  for (@$ar) {
    slide { 
      ($g{$a}{$b},$g{$b}{$a}) = (1,1);
    } @$_;
  }

  my @p = Paths::Graph->new(-origin => $o, -destiny => $d, -graph => \%g)->shortest_path;

  return (scalar @p == 1 and defined $p[0][1] ? $p[0] : undef);
}

cmp_deeply(shortestRoute(1,7,@{[[1,2,6],[5,6,7]]}),
           [1,2,6,7]);
cmp_deeply(shortestRoute(2,5,@{[[1,2,3],[4,5,6]]}),
           undef);
cmp_deeply(shortestRoute(1,7,@{[[1,2,3],[4,5,6],[3,8,9],[7,8]]}),
           [1,2,3,8,7]);

done_testing;
