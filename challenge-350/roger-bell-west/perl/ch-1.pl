#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(goodsubstrings('abcaefg'), 5, 'example 1');
is(goodsubstrings('xyzzabc'), 3, 'example 2');
is(goodsubstrings('aababc'), 1, 'example 3');
is(goodsubstrings('qwerty'), 4, 'example 4');
is(goodsubstrings('zzzaaa'), 0, 'example 5');

use List::Util qw(max);

sub counterify($a) {
  my %m;
  foreach my $i (@{$a}) {
    $m{$i}++;
  }
  return \%m;
}

sub goodsubstrings($a) {
  my $p = 0;
  foreach my $si (0 .. length($a) - 3) {
    my $c = counterify([split '', substr($a, $si, 3)]);
    if (max(values %{$c}) == 1) {
      $p++;
    }
  }
  $p;
}
