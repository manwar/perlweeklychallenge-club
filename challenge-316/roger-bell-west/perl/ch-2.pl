#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(subsequence('uvw', 'bcudvew'), 1, 'example 1');
is(subsequence('aec', 'abcde'), 0, 'example 2');
is(subsequence('sip', 'javascript'), 1, 'example 3');

sub subsequence($a, $b) {
  my $l = $a;
  my $s = $b;
  if (length($a) < length($b)) {
    $l = $b;
    $s = $a;
  }
  my @st = split '', $s;
  my $si = 0;
  foreach my $c (split '', $l) {
    if ($c eq $st[$si]) {
      $si++;
      if ($si >= scalar @st) {
        return 1;
      }
    }
  }
  0;
}
