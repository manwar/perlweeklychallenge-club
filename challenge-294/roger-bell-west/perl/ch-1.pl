#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(consecutivesequence([10, 4, 20, 1, 3, 2]), 4, 'example 1');
is(consecutivesequence([0, 6, 1, 8, 5, 2, 4, 3, 0, 7]), 9, 'example 2');
is(consecutivesequence([10, 30, 20]), -1, 'example 3');

use List::Util qw(max);

sub consecutivesequence($a) {
  my @b = sort {$::a <=> $::b} @{$a};
  my $mxlen = 0;
  my $here = 0;
  while (1) {
    foreach my $there (($here + 1) .. $#b) {
      if ($b[$there] != $there - $here + $b[$here]) {
        $mxlen = max($mxlen, $there - $here);
        $here = $there;
        last;
      }
      if ($there == $#b) {
        $mxlen = max($mxlen, $there - $here + 1);
        $here = $there;
        last;
      }
    }
    if ($here >= $#b) {
      last;
    }
  }
  if ($mxlen < 2) {
    $mxlen = -1;
  }
  $mxlen;
}
