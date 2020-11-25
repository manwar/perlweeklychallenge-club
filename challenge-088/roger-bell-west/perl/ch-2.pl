#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(sm([
  [ 1, 2, 3 ],
  [ 4, 5, 6 ],
  [ 7, 8, 9 ],
    ]),[1, 2, 3, 6, 9, 8, 7, 4, 5],'example 1');
is_deeply(sm([
  [  1,  2,  3,  4 ],
  [  5,  6,  7,  8 ],
  [  9, 10, 11, 12 ],
  [ 13, 14, 15, 16 ],
    ]),[1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10],'example 2');

sub sm {
  my $m=shift;
  my $mx=scalar @{$m};
  my $my=scalar @{$m->[0]};
  my @o=($m->[0][0]);
  my @v;
  foreach (1..$mx) {
    push @v,[(0) x $my];
  }
  my @dir=(
    [0,1],
    [1,0],
    [0,-1],
    [-1,0],
      );
  my ($x,$y,$d)=(0,0,0);
  foreach (2..$mx*$my) {
    $v[$x][$y]=1;
    my ($nx,$ny);
    while (1) {
      ($nx,$ny)=($x+$dir[$d][0],$y+$dir[$d][1]);
      if ($nx<0 || $nx>=$mx || $ny<0 || $ny>=$my || $v[$nx][$ny]==1) {
        $d++;
        $d%=4;
      } else {
        last;
      }
    }
    ($x,$y)=($nx,$ny);
    push @o,$m->[$x][$y];
  }
  return \@o;
}
