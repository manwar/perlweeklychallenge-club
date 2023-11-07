#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(missingmembers([1, 2, 3], [2, 4, 6]), [[1, 3], [4, 6]], 'example 1');
is_deeply(missingmembers([1, 2, 3, 3], [1, 1, 2, 2]), [[3], []], 'example 2');

use List::Util qw(uniq);

sub halfmissing($a, $bh) {
  return [uniq grep {!exists $bh->{$_}} @{$a}];
}

sub missingmembers($a, $b) {
  my $ah = {map {$_ => 1} @{$a}};
  my $bh = {map {$_ => 1} @{$b}};
  return [
    halfmissing($a, $bh),
    halfmissing($b, $ah),
      ];
}
