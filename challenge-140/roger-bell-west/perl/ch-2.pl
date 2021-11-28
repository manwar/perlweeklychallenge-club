#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(mtable(2,3,4),3,'example 1');
is(mtable(3,3,6),4,'example 2');

sub mtable {
  my ($i,$j,$k)=@_;
  my @l;
  foreach my $a (1..$i) {
    push @l,map {$a*$_} (1..$j);
  }
  @l=sort @l;
  return $l[$k-1];
}
