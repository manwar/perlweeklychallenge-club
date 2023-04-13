#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

use List::Util qw(min);

is_deeply(rearrangegroups([1, 2, 3, 5, 1, 2, 7, 6, 3], 3), [[1, 2, 3], [1, 2, 3], [5, 6, 7]], 'example 1');
is_deeply(rearrangegroups([1, 2, 3], 2), [], 'example 2');
is_deeply(rearrangegroups([1, 5, 2, 6, 4, 7], 3), [], 'example 3');

sub rearrangegroups($list, $size) {
  my %h;
  map {$h{$_}++} @{$list};
  my @out;
  while (1) {
    my $m = min(keys %h);
    my @res = ($m .. $m + $size - 1);
    foreach my $n (@res) {
      if (exists $h{$n}) {
        $h{$n}--;
        if ($h{$n} == 0) {
          delete $h{$n};
        }
      } else {
        return [];
      }
    }
    push @out,\@res;
    unless (%h) {
      last;
    }
  }
  return \@out;
}
