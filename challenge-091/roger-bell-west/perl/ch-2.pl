#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(jg([1,2,1,2]),1,'example 1');
is(jg([2,1,1,0,2]),0,'example 2');

sub jg {
  my $n=shift;
  my $mx=$#{$n};
  my $p=0;
  while (1) {
    $p+=$n->[$p];
    if ($p == $mx) {
      return 1;
    } elsif ($p > $mx || $n->[$p] == 0) {
      return 0;
    }
  }
}
