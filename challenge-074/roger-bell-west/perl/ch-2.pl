#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(fnr('ababc'),
   'abb#c',
   "example 1");
is(fnr('xyzzyx'),
   'xyzyx#',
   "example 2");

sub fnr {
  my $in=shift;
  my %s;
  my @s;
  my @o;
  foreach my $c (split '',$in) {
    push @s,$c;
    $s{$c}++;
    @s=grep {$s{$_}<2} @s;
    if (@s) {
      push @o,$s[-1];
    } else {
      push @o,'#';
    }
  }
  return join('',@o);
}
