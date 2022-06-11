#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;
use List::Util qw(sum);

is(equilibriumindex([1,3,5,7,9]),3,'example 1');
is(equilibriumindex([1,2,3,4,5]),-1,'example 2');
is(equilibriumindex([2,4,2]),1,'example 3');

sub equilibriumindex {
  my $s=shift;
  my $sm=sum(@{$s});
  my $sa=0;
  foreach my $i (0..$#{$s}) {
    $sa += $s->[$i];
    if ($sa == $sm) {
      return $i;
    }
    $sa += $s->[$i];
  }
  return -1;
}
