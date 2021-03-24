#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(nroot(5,248832),12,'example 1');
is(nroot(5,34),34**0.2,'example 2');

sub nroot {
  my $n=shift;
  my $a=shift;
  my $xk=2;
  while (1) {
    my $xk1=(($n-1)*$xk+$a/($xk ** ($n-1)))/$n;
    if ($xk1==$xk) {
      last;
    }
    $xk=$xk1;
  }
  return $xk;
}

