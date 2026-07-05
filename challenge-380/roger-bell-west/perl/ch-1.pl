#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(sumoffrequencies('banana'), 5, 'example 1');
is(sumoffrequencies('teestett'), 7, 'example 2');
is(sumoffrequencies('aeiouuaa'), 3, 'example 3');
is(sumoffrequencies('rhythm'), 2, 'example 4');
is(sumoffrequencies('x'), 1, 'example 5');

sub sumoffrequencies($a) {
  my $vw = 0;
  my $cn = 0;
  my %cc;
  foreach my $c (split '', $a) {
    $cc{$c}++;
  }
  my @cv = reverse sort values %cc;
  foreach my $n (@cv) {
    while (my ($c, $ni) = each %cc) {
      if ($ni == $n) {
        if ($c eq 'a' || $c eq 'e' || $c eq 'i'|| $c eq 'o' || $c eq 'u') {
          if ($vw == 0) {
            $vw = $n;
          }
        } else {
          if ($cn == 0) {
            $cn = $n;
          }
        }
        if ($vw > 0 && $cn > 0) {
          last;
        }
      }
    }
    if ($vw > 0 && $cn > 0) {
      last;
    }
  }
  $vw + $cn;
}
