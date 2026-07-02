#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);
use Test::More tests => 5;

sub sum_of_frequencies {
  my %h;
  $h{$_}++ foreach split '', lc $_[0];
  my ($c, $v) = (0, 0);
  foreach (keys %h) {
    /[aeiou]/ ? ($v = max($v, $h{$_})) : ($c = max($c, $h{$_}));
  }
  $c + $v;
}

is sum_of_frequencies('banana'),5,'Example 1';
is sum_of_frequencies('teestett'),7,'Example 2';
is sum_of_frequencies('aeiouuaa'),3,'Example 3';
is sum_of_frequencies('rhythm'),2,'Example 4';
is sum_of_frequencies('x'),1,'Example 5';

