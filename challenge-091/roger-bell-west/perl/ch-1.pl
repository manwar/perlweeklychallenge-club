#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(cn('1122234'),'21321314','example 1');
is(cn('2333445'),'12332415','example 2');
is(cn('12345'),'1112131415','example 3');

sub cn {
  my $n=shift;
  my @j=$n =~ /((.)\2*)/g;
  my @out;
  while (@j) {
    push @out,length(shift @j);
    push @out,shift @j;
  }
  return join('',@out);
}
