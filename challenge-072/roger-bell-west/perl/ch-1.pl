#! /usr/bin/perl

use strict;
use warnings;

use Math::GMP;
use Test::More tests => 5;

is(zerofact(10),2,'ten');
is(zerofact(7),1,'seven');
is(zerofact(4),0,'four');
is(zerofact(69),15,'sixty-nine');
is(zerofact(125),31,'one hundred and twenty-five');

sub zerofact {
  my $n=shift;
  $n=Math::GMP->new($n);
  my $f=$n->bfac->get_str_gmp(10);
  my $l=0;
  $f =~ /(0+)$/;
  if (defined $1) {
    $l=length($1);
  }
  return $l;
}
