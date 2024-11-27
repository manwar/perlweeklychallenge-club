#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use List::Util qw(min);

sub jumpgame($a) {
  my $target = $#{$a};
  my %here = (0 => 1);
  my $moves = 0;
  while (1) {
    $moves++;
    my %there;
    foreach my $n (keys %here) {
      foreach my $i (($n + 1) .. min($n + $a->[$n], $target)) {
        $there{$i} = 1;
      }
    }
    if (scalar keys %there == 0) {
      return -1
    }
    if (exists $there{$target}) {
      return $moves;
    }
    %here = %there;
  }
}

use Test::More tests => 3;

is(jumpgame([2, 3, 1, 1, 4]), 2, 'example 1');
is(jumpgame([2, 3, 0, 4]), 2, 'example 2');
is(jumpgame([2, 0, 0, 4]), -1, 'example 3');
