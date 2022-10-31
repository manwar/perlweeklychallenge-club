#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

use List::Util qw(max);

is_deeply(arraydegree([1, 3, 3, 2]), [3, 3], 'example 1');
is_deeply(arraydegree([1, 2, 1, 3]), [1, 2, 1], 'example 2');
is_deeply(arraydegree([1, 3, 2, 1, 2]), [2, 1, 2], 'example 3');
is_deeply(arraydegree([1, 1, 2, 3, 2]), [1, 1], 'example 4');
is_deeply(arraydegree([2, 1, 2, 1, 1]), [1, 2, 1, 1], 'example 5');

sub arraydegree($a) {
  my %f;
  map {$f{$_}++} @{$a};
  my $degree = max(values %f);
  my %inverse;
  foreach my $i (0..$#{$a}) {
    push @{$inverse{$a->[$i]}}, $i;
  }
  my $minlen = 2 + $#{$a};
  my @se;
  foreach my $n (grep {$f{$_} == $degree} keys %f) {
    my $ll = 1 + $inverse{$n}[-1] - $inverse{$n}[0];
    if ($ll < $minlen) {
      $minlen = $ll;
      @se = ($inverse{$n}[0], $inverse{$n}[-1]);
    }
  }
  return [@{$a}[$se[0]..$se[1]]];
}
