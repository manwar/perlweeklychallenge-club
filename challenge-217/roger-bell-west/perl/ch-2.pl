#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(maxnumber([1, 23]), 231, 'example 1');
is(maxnumber([10, 3, 2]), 3210, 'example 2');
is(maxnumber([31, 2, 4, 10]), 431210, 'example 3');
is(maxnumber([5, 11, 4, 1, 2]), 542111, 'example 4');
is(maxnumber([1, 10]), 110, 'example 5');

use List::Util qw(max);

sub maxnumber($lst) {
  my @po = map{"" . $_} @{$lst};
  my $pl = max(map {length($_)} @po);
  my @pm;
  foreach my $so (@po) {
    my $sm = $so;
    my @q = split '',$so;
    if (scalar @q < $pl) {
      my $c = $q[-1];
      $sm .= $c x ($pl - scalar @q);
    }
    push @pm, $sm;
  }
  my $out = '';
  my @pi = (0..$#pm);
  foreach my $st (sort {$pm[$b] cmp $pm[$a]} @pi) {
    $out .= $po[$st];
  }
  return 0 + $out;
}
