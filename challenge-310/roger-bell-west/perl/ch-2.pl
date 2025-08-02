#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(sortoddeven([4, 1, 2, 3]), [2, 3, 4, 1], 'example 1');
is_deeply(sortoddeven([3, 1]), [3, 1], 'example 2');
is_deeply(sortoddeven([5, 3, 2, 1, 4]), [2, 3, 4, 1, 5], 'example 3');

use List::Util qw(max);

sub sortoddeven($a) {
  my @odds;
  my @evens;
  while (my ($i, $x) = each @{$a}) {
    if ($i % 2 == 0) {
      push @evens, $x;
    } else {
      push @odds, $x;
    }
  }
  @evens = sort {$::a <=> $::b} @evens;
  @odds = sort {$::b <=> $::a} @odds;
  my @out;
  foreach my $i (0 .. max($#evens, $#odds)) {
    if ($i <= $#evens) {
      push @out, $evens[$i];
    }
    if ($i <= $#odds) {
      push @out, $odds[$i];
    }
  }
  \@out;
}
