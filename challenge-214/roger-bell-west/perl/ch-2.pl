#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(collectpoints([2, 4, 3, 3, 3, 4, 5, 4, 2]), 23, 'example 1');
is(collectpoints([1, 2, 2, 2, 2, 1]), 20, 'example 2');
is(collectpoints([1]), 1, 'example 3');
is(collectpoints([2, 2, 2, 1, 1, 2, 2, 2]), 40, 'example 4');

use Storable qw(dclone);
use List::Util qw(max);

sub collectpoints($a) {
  my @m;
  my $s = 0;
  while ($s <= $#{$a}) {
    my $k = $a->[$s];
    my $e = $s;
    while ($e <= $#{$a} && $a->[$e] == $k) {
      $e++;
    }
    push @m,[$k, $e - $s];
    $s = $e;
  }
  my $rv = 0;
  my @stack = ([\@m, 0]);
  while (scalar @stack > 0) {
    my $s = pop @stack;
    if (scalar @{$s->[0]} == 0) {
      $rv = max($rv, $s->[1]);
    } else {
      foreach my $i (0..$#{$s->[0]}) {
        my $ss = dclone($s);
        $ss->[1] += $ss->[0][$i][1] * $ss->[0][$i][1];
        splice @{$ss->[0]}, $i, 1;
        my $j = $i;
        while (1) {
          if ($j > 0 &&
                   $j < scalar @{$ss->[0]} &&
                   $ss->[0][$j][0] == $ss->[0][$j-1][0]) {
            $ss->[0][$j][1] += $ss->[0][$j-1][1];
            splice @{$ss->[0]}, $j - 1, 1;
            $j--;
          } else {
            last;
          }
        }
        push @stack, $ss;
      }
    }
  }
  return $rv;
}
