#! /usr/bin/perl

use strict;
use warnings;
use List::Util qw(min);

use Test::More tests => 2;

is(lrhist(2,1,4,5,3,7),
   12,
   "example 1");

is(lrhist(3,2,3,5,7,5),
   15,
   "example 2");

sub lrhist {
  my @c=@_;
  my $bestarea=0;
  my @n=(0,0);
  foreach my $a (0..$#c-1) {
    foreach my $b ($a+1..$#c) {
      my $area=($b-$a+1)*min(@c[$a..$b]);
      if ($area>$bestarea) {
        $bestarea=$area;
        @n=($a,$b);
      }
    }
  }
  return $bestarea;
}
