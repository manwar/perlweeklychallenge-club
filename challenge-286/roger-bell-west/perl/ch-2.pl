#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(ordergame([2, 1, 4, 5, 6, 3, 0, 2]), 1, 'example 1');
is(ordergame([0, 5, 3, 2]), 0, 'example 2');
is(ordergame([9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]), 2, 'example 3');

use List::Util qw(min max);
use List::MoreUtils qw(slideatatime);

sub ordergame($a) {
  my @p = @{$a};
  while (scalar @p > 1) {
    my @q;
    my $mm = 1;
    my $dd = slideatatime 1, 2, @p;
    while (my @j = $dd->()) {
      if (scalar @j == 2) {
        if ($mm) {
          push @q, min(@j);
        } else {
          push @q, max(@j);
        }
        $mm = 1 - $mm;
      }
    }
    @p = @q;
  }
  return $p[0];
}
