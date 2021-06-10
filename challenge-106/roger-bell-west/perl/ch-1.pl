#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(mg(2,9,3,5),4,'example 1');
is(mg(1,3,8,2,0),5,'example 2');
is(mg(5),0,'example 3');

sub mg {
  my @a=sort @_;
  my $g=0;
  foreach my $i (0..$#a-1) {
    my $d=abs($a[$i]-$a[$i+1]);
    if ($d>$g) {
      $g=$d;
    }
  }
  return $g;
}

