#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(backspacecompare('ab#c', 'ad#c'), 1, 'example 1');
is(backspacecompare('ab##', 'a#b#'), 1, 'example 2');
is(backspacecompare('a#b', 'c'), 0, 'example 3');

sub backspacecompare($a, $b) {
  my @sa;
  foreach my $i ($a, $b) {
    my @oa;
    foreach my $c (split '', $i) {
      if ($c eq '#') {
        pop @oa;
      } else {
        push @oa, $c;
      }
    }
    push @sa, join('', @oa);
  }
  ($sa[0] eq $sa[1])?1:0;
}
