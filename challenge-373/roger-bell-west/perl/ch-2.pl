#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(listdivision([1, 2, 3, 4, 5], 2), [[1, 2, 3], [4, 5]], 'example 1');
is_deeply(listdivision([1, 2, 3, 4, 5, 6], 3), [[1, 2], [3, 4], [5, 6]], 'example 2');
is_deeply(listdivision([1, 2, 3], 2), [[1, 2], [3]], 'example 3');
is_deeply(listdivision([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 5), [[1, 2], [3, 4], [5, 6], [7, 8], [9, 10]], 'example 4');
is_deeply(listdivision([1, 2, 3], 4), [], 'example 5');

sub listdivision($a, $n) {
  my $al = scalar @{$a};
  if ($n > $al) {
    return [];
  }
  my @divsize = (int ($al / $n)) x $n;
  foreach my $i (0 .. ($al % $n) - 1) {
    $divsize[$i] += 1;
  }
  my @out;
  my $x = 0;
  my @a = @{$a};
  foreach my $s (@divsize) {
    my @r = @a[$x .. $x + $s - 1];
    push @out, \@r;
    $x += $s;
  }
  \@out;
}
