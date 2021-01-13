#! /usr/bin/perl

use strict;
use warnings;
use List::Util qw(sum);

use Test::More tests => 1;

is(coinsum([1,2,4],6),
   6,
   "example");

sub coinsum {
  my $c=shift;
  my @c=@{$c};
  my $s=shift;
  my @m;
  foreach (0..$#c) {
    push @m,int($s/$c[$_]);
  }
  my @out;
  my @b=(0) x scalar @c;
 OUTER:
  while (1) {
    my $v=sum(map {$c[$_]*$b[$_]} (0..$#c));
    if ($v==$s) {
      push @out,\@b;
    }
    my $i=0;
    while (1) {
      $b[$i]++;
      if ($b[$i]>$m[$i]) {
        $b[$i]=0;
        $i++;
        if ($i>$#b) {
          last OUTER;
        }
      } else {
        last;
      }
    }
  }
  return scalar @out;
}
