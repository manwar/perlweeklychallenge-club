#! /usr/bin/perl

use strict;

use Test::More tests => 1;
use List::Util qw(max);

is(btd([1,
        2,5,
        3,4,6,7,
        0,0,0,0,0,0,8,10,
        0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0]),6,'example 1');

sub btd {
  my $tree=shift;
  my $st=scalar @{$tree};
  my @depth=(0) x $st;
  my @diameter=(0) x $st;
  for (my $i=$st-1;$i>=0;$i--) {
    if ($tree->[$i] != 0) {
      my $a=$i*2+1;
      my $b=$a+1;
      if ($b < $st) {
        $depth[$i]=1+max($depth[$a],$depth[$b]);
        $diameter[$i]=max($depth[$a]+$depth[$b],
                          $diameter[$a],
                          $diameter[$b]);
      } else {
        $depth[$i]=1;
      }
    }
  }
  return $diameter[0];
}
