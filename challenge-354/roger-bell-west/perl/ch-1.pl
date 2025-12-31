#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(minabsdiff([4, 2, 1, 3]), [[1, 2], [2, 3], [3, 4]], 'example 1');
is_deeply(minabsdiff([10, 100, 20, 30]), [[10, 20], [20, 30]], 'example 2');
is_deeply(minabsdiff([-5, -2, 0, 3]), [[-2, 0]], 'example 3');
is_deeply(minabsdiff([8, 1, 15, 3]), [[1, 3]], 'example 4');
is_deeply(minabsdiff([12, 5, 9, 1, 15]), [[9, 12], [12, 15]], 'example 5');

use List::MoreUtils qw(slide);

sub minabsdiff($a) {
  my @b = sort {$::a <=> $::b} @{$a};
  my @out;
  my $mindiff = 1 + $b[-1] - $b[0];
  slide {
    my $d = $::b - $::a;
    if ($d < $mindiff) {
      @out = ();
      $mindiff = $d;
    }
    if ($d == $mindiff) {
      push @out, [$::a, $::b];
    }
  } @b;
  \@out;
}
