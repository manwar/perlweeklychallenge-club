#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(distringmatch('IDID'), [0, 4, 1, 3, 2], 'example 1');
is_deeply(distringmatch('III'), [0, 1, 2, 3], 'example 2');
is_deeply(distringmatch('DDI'), [3, 2, 0, 1], 'example 3');

sub distringmatch($a) {
  my $v = 1 << (length($a) - 1);
  my $wv = $v << 1;
  my @out = ($wv);
  foreach my $c (split '', $a) {
    if ($c eq 'I') {
      $wv += $v
    } else {
      $wv -= $v;
    }
    $v >>= 1;
    push @out, $wv;
  }
  my @r = sort{$::a <=> $::b} @out;
  my %c = map {$r[$_] => $_} (0..$#r);
  return [map{$c{$_}} @out];
}
