#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(linecounts('abcdefghijklmnopqrstuvwxyz', [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]), [3, 60], 'example 1');
is_deeply(linecounts('bbbcccdddaaa', [4, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]), [2, 4], 'example 2');

sub linecounts($a, $w) {
  my $linecount = 1;
  my $linewidth = 0;
  my $asize = ord('a');
  foreach my $c (split '',$a) {
    my $wd = $w->[ord($c) - $asize];
    if ($linewidth + $wd > 100) {
      $linecount++;
      $linewidth = $wd;
    } else {
      $linewidth += $wd;
    }
  }
  return [$linecount, $linewidth];
}
