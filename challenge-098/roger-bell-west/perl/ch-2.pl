#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;

is(sip([1,2,3,4],3),2,'example 1');
is(sip([1,3,5,7],6),3,'example 2');
is(sip([12,14,16,18],10),0,'example 3');
is(sip([11,13,15,17],19),4,'example 4');

sub sip {
  my $n=shift;
  my $t=shift;
  if ($n->[-1] < $t) {
    return scalar @{$n};
  }
  my ($l,$h)=(0,$#{$n});
  while ($h-$l > 1) {
    my $m=int(($h+$l)/2);
    if ($n->[$m] == $t) {
      return $m;
    } elsif ($n->[$m] > $t) {
      $h=$m;
    } else {
      $l=$m;
    }
  }
  if ($n->[$l] >= $t) {
    return $l;
  }
  return $h;
}
