#!/usr/bin/env raku
use v6;

sub noConnection(@routes) {
  my $starts = set @routes.map({ .[0] });
  my $ends   = set @routes.map({ .[1] });
  my $noConnection = $ends (-) $starts;
  return 'no terminal destinations'
    if $noConnection.elems == 0;
  return 'multiple terminal destinations'
    if $noConnection.elems > 1;
  return $noConnection;
}

sub tupleJoin(@list) {
  return @list.map({ '[' ~ .[0] ~ ', ' ~ .[1] ~  ']'})
              .join(', ');
}

sub solution(@routes) {
  say 'Input: @routes = (' ~ tupleJoin(@routes) ~ ')';
  say 'Output: ' ~ noConnection(@routes);
}

say "Example 1:";
solution([["B","C"], ["D","B"], ["C","A"]]);

say "\nExample 2:";
solution([["A","Z"], ]);

say "\nBad Input: multiple terminal destinations";
solution([["A","B"], ["C", "D"]]);

say "\nBad Input: no terminal destinations";
solution([["A","Z"], ["Z", "A"]]);
