#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(sos(34),1,'example 1');
is(sos(50),1,'example 2');
is(sos(52),0,'example 3');

sub sos {
  my $n=shift;
  my $t=0;
  foreach (split '',$n) {
    $t+=$_*$_;
  }
  my $s=int(sqrt($t));
  if ($s*$s==$t) {
    return 1;
  }
  return 0;
}
