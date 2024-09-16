#!/usr/bin/env perl
use v5.40;

use Set::Scalar;

sub noConnection(@routes) {
  my $starts = Set::Scalar->new(map { $_->[0] } @routes);
  my $ends   = Set::Scalar->new(map { $_->[1] } @routes);
  my $noConnection = $ends - $starts;
  return 'no terminal destinations'
    if $noConnection->is_empty;
  return 'multiple terminal destinations'
    if $noConnection->size > 1;
  return ($noConnection->elements)[0];
}

sub tupleJoin(@list) {
  return join(
    ', ',
    map { '[' . $_->[0] . ', ' . $_->[1] .  ']' } @list
  );
}

sub solution($routes) {
  say 'Input: @routes = (' . tupleJoin(@$routes) . ')';
  say 'Output: ' . noConnection(@$routes);
}

say "Example 1:";
solution([["B","C"], ["D","B"], ["C","A"]]);

say "\nExample 2:";
solution([["A","Z"], ]);

say "\nBad Input: multiple terminal destinations";
solution([["A","B"], ["C", "D"]]);

say "\nBad Input: no terminal destinations";
solution([["A","Z"], ["Z", "A"]]);
