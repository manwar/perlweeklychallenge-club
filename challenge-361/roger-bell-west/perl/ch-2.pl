#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 6;

is(findcelebrity([[0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0]]), 4, 'example 1');
is(findcelebrity([[0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1], [1, 0, 0, 0]]), -1, 'example 2');
is(findcelebrity([[0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 0, 0, 0, 0]]), 0, 'example 3');
is(findcelebrity([[0, 1, 0, 1, 0, 1], [1, 0, 1, 1, 0, 0], [0, 0, 0, 1, 1, 0], [0, 0, 0, 0, 0, 0], [0, 1, 0, 1, 0, 0], [1, 0, 1, 1, 0, 0]]), 3, 'example 4');
is(findcelebrity([[0, 1, 1, 0], [1, 0, 1, 0], [0, 0, 0, 0], [0, 0, 0, 0]]), -1, 'example 5');
is(findcelebrity([[0, 0, 1, 1], [1, 0, 0, 0], [1, 1, 0, 1], [1, 1, 0, 0]]), -1, 'example 6');

use Storable qw(dclone);
use List::Util qw(all);

sub findcelebrity($a) {
  my %knowsnobody;
  my %everybodyknows;
  foreach my $i (0 ..$#{$a}) {
    my @ek = map {$_->[$i]} @{$a};
    splice @ek, $i, 1;
    if (all {$_ == 1} @ek) {
      $everybodyknows{$i}++;
    }
    my @kn = @{dclone($a->[$i])};
    splice @kn, $i, 1;
    if (all {$_ == 0} @kn) {
      $knowsnobody{$i}++;
    }
  }
  my %celebs;
  foreach my $k (keys %everybodyknows) {
    if (exists $knowsnobody{$k}) {
      $celebs{$k} = 1;
    }
  }
  if (scalar %celebs != 1 ) {
    return -1;
  }
  (keys %celebs)[0];
}
