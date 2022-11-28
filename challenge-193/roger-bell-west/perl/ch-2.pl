#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(oddstring(["adc", "wzy", "abc"]), "abc", 'example 1');
is(oddstring(["aaa", "bob", "ccc", "ddd"]), "bob", 'example 2');

sub oddstring($ss) {
  foreach my $i (0..length($ss->[0])-2) {
    my %tab;
    foreach my $s (@{$ss}) {
      my $v = ord(substr($s,$i+1,1)) - ord(substr($s,$i,1));
      push @{$tab{$v}}, $s;
    }
    foreach my $j (values %tab) {
      if (scalar @{$j} == 1) {
        return $j->[0];
      }
    }
  }
  return '';
}
