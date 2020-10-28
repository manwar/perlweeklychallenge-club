#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(ri(1234),4321,'example 1');
is(ri(-1234),-4321,'example 2');
is(ri(1231230512),0,'example 3');

sub ri {
  my $s=shift;
  my $r=join('',reverse split '',$s);
  if ($r =~ /([0-9]+)-$/) {
    $r="-$1";
  }
  if (unpack('l',pack('l',$r)) != $r) {
    return 0;
  }
  return $r;
}
