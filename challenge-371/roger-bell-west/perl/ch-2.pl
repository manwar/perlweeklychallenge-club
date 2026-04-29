#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(subsetequilibrium([2, 1, 4, 3]), [[1, 4], [2, 1], [2, 3], [4, 3]], 'example 1');
is_deeply(subsetequilibrium([3, 0, 3, 0]), [[3], [3, 0], [3, 0, 3]], 'example 2');
is_deeply(subsetequilibrium([5, 1, 1, 1]), [[5, 1, 1]], 'example 3');
is_deeply(subsetequilibrium([3, -1, 4, 2]), [[3, -1, 4], [3, 2]], 'example 4');
is_deeply(subsetequilibrium([10, 20, 30, 40]), [], 'example 5');

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum min);

sub subsetequilibrium($a) {
    my @out;
    my @b;
    while (my ($i, $x) = each @{$a}) {
        push @b, $x - $i - 1;
    }
    my @ix = (0 .. $#b);
    foreach my $n (1 .. $#b) {
      my $ip = combinations(\@ix, $n);
      while (my $iy = $ip->next) {
            my @bp = map {$b[$_]} @{$iy};
            if (sum(@bp) == 0) {
              my @ap = map {$a->[$_]} @{$iy};
              push @out, \@ap;
            }
        }
    }
    @out = sort {
      my $kx = min(scalar @{$::a}, scalar @{$::b});
      my $k = 0;
      my $cmp = $::a->[0] <=> $::b->[0];
      while ($k < $kx) {
        if ($::a->[$k] == $::b->[$k]) {
          $k += 1;
        } else {
          $cmp = $::a->[$k] <=> $::b->[$k];
          last;
        }
      }
      $cmp;
    } @out;
    \@out;
}
