#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

use List::Util qw(max);

is(maxgap([2, 5, 8, 1]), 2, 'example 1');
is(maxgap([3]), 0, 'example 2');

sub maxgap($l0) {
  if (scalar @{$l0} < 2) {
    return 0;
  }
  my @l = sort @{$l0};
  my @q;
  foreach my $i (0 .. $#l-1) {
    push @q,$l[$i+1] - $l[$i];
  }
  my $mq = max(@q);
  return scalar grep {$_ == $mq} @q;
}
