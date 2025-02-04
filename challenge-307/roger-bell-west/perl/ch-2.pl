#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(findanagrams(['acca', 'dog', 'god', 'perl', 'repl']), 3, 'example 1');
is(findanagrams(['abba', 'baba', 'aabb', 'ab', 'ab']), 2, 'example 2');

sub findanagrams($a) {
  my @b;
  foreach my $s (@{$a}) {
    push @b, join("", sort split("", $s));
  }
  my $out = 1;
  foreach my $i (1 .. $#b) {
    if ($b[$i - 1] ne $b[$i]) {
      $out++;
    }
  }
  $out;
}
