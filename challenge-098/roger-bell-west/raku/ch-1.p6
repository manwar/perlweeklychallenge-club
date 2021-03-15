#! /usr/bin/perl6

use Test;

plan 3;

sub readN($fnn,$siz) {
  state $fh=0;
  state $fn='';
  if ($fnn ne $fn) {
    $fn=$fnn;
    if ($fh) {
      $fh.close;
      $fh=0;
    }
  }
  unless ($fh) {
    $fh=$fn.IO.open;
  }
  my $buf=$fh.read($siz).decode;
  if ($buf.chars < $siz) {
    $fh.close;
    $fh=0;
    $fn='';
  }
  return $buf;
}

is(readN('input.txt',4),'1234','example 1');
is(readN('input.txt',4),'5678','example 2');
is(readN('input.txt',4),'90','example 3');
