#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(popularword('Bob hit a ball, the hit BALL flew far after it was hit.', ['hit']), 'ball', 'example 1');
is(popularword('Apple? apple! Apple, pear, orange, pear, apple, orange.', ['apple', 'pear']), 'orange', 'example 2');
is(popularword('A. a, a! A. B. b. b.', ['b']), 'a', 'example 3');
is(popularword('Ball.ball,ball:apple!apple.banana', ['ball']), 'apple', 'example 4');
is(popularword('The dog chased the cat, but the dog was faster than the cat.', ['the', 'dog']), 'cat', 'example 5');

sub popularword($a, $banned) {
  my %w;
  foreach my $word (grep /./, split /[^a-z]+/, lc($a)) {
    $w{$word}++;
  }
  map {delete $w{$_}} @{$banned};
  my @k = keys %w;
  my @v = map {$w{$_}} @k;
  my @i = sort {$v[$::b] <=> $v[$::a]} (0..$#v);
  $k[$i[0]];
}
