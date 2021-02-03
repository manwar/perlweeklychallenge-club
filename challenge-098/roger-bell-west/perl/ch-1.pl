#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

{
  my $fh;
  my $fn='';
  sub readN {
    my $fnn=shift;
    if ($fnn ne $fn) {
      $fn=$fnn;
      if (defined $fh) {
        close $fh;
        undef $fh;
      }
    }
    if (!defined $fh) {
      open $fh,'<',$fn;
    }
    my $buf;
    my $l=read ($fh,$buf,4);
    if ($l < 4) {
      close $fh;
      undef $fh;
      $fn='';
    }
    return $buf;
  }
}

is(readN('input.txt'),'1234','example 1');
is(readN('input.txt'),'5678','example 2');
is(readN('input.txt'),'90','example 3');
