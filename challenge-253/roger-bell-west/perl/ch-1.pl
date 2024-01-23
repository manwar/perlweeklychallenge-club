#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(splitstrings(['one.two.three', 'four.five', 'six'], '.'), ['one', 'two', 'three', 'four', 'five', 'six'], 'example 1');
is_deeply(splitstrings(['$perl$$', '$$raku$'], '$'), ['perl', 'raku'], 'example 2');

sub splitstrings($a, $ssep) {
  my @p;
  (my $sep = $ssep) =~ s/([^A-Z0-9])/\\$1/gi;
  foreach my $s (@{$a}) {
    push @p, grep /./, split($sep, $s);
  }
  return \@p;
}
