#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(nestedarray([5, 4, 0, 3, 1, 6, 2]), 4, 'example 1');
is(nestedarray([0, 1, 2]), 1, 'example 2');

use List::Util qw(max);

sub nestedarray($a) {
  my $arr = 0;
  foreach my $i (0 .. scalar @{$a} - 1) {
    my %trail;
    my $j = $i;
    while (1) {
      $j = $a->[$j];
      if (exists $trail{$j}) {
        last;
      }
      $trail{$j} = 1;
    }
    $arr = max($arr, scalar keys %trail);
  }
  $arr;
}
