#! /usr/bin/perl

use strict;
use warnings FATAL => 'all';

use Test::More tests => 3;
use List::Util qw(min);

is(un(7),8,'example 1');
is(un(10),12,'example 2');
is(un(200),16200,'example 3');

sub un {
  my $m=shift;
  my $n;
  my @s=([1],[1],[1]);
  my @c=(2,3,5);
  foreach (1..$m) {
    $n=min($s[0][0],$s[1][0],$s[2][0]);
    foreach my $i (0..2) {
      if ($s[$i][0]==$n) {
        shift @{$s[$i]};
      }
      push @{$s[$i]},$n*$c[$i];
    }
  }
  return $n;
}
