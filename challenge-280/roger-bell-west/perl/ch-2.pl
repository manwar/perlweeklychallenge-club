#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(countasterisks('p|*e*rl|w**e|*ekly|'), 2, 'example 1');
is(countasterisks('perl'), 0, 'example 2');
is(countasterisks('th|ewe|e**|k|l***ych|alleng|e'), 5, 'example 3');

sub countasterisks($a) {
  my $out = 0;
  my $active = 1;
  foreach my $c (split '', $a) {
    if ($c eq '|') {
      $active = 1 - $active;
    } elsif ($c eq '*') {
      if ($active) {
        $out++;
      }
    }
  }
  $out;
}
