#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(ed('kitten','sitting'),3,'example 1');
is(ed('sunday','monday'),2,'example 2');
is(ed('branscombe','ranscombe'),1,'example 3');

use List::Util qw(min);

sub ed {
  my ($s,$t)=@_;
  my @s=(0,split '',$s);
  my @t=(0,split '',$t);
  my @d;
  foreach (0..$#s) {
    push @d,[(0) x ($#t+1)];
  }
  map {$d[$_][0]=$_} 1..$#s;
  map {$d[0][$_]=$_} 1..$#t;
  foreach my $j (1..$#t) {
    foreach my $i (1..$#s) {
      my $sc=0;
      if ($s[$i] ne $t[$j]) {
        $sc=1;
      }
      $d[$i][$j]=min(
        $d[$i-1][$j]+1,
        $d[$i][$j-1]+1,
        $d[$i-1][$j-1]+$sc,
          );
    }
  }
  return $d[$#s][$#t];
}
