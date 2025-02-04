#!/usr/bin/env perl
use strict;
use warnings;

sub find_anagrams{
  my ($arr) = @_;
  my @sorted = map {join'',sort split ''} @$arr;
  my $sum = 1;
  map{$sum++ if $sorted[$_-1] ne $sorted[$_]} 1..$#sorted;
  $sum
}

printf "%d\n",find_anagrams(['acca','dog','god','perl','repl']);
printf "%d\n",find_anagrams(['abba','baba','aabb','ab','ab']);

