#! /usr/bin/perl6

use Test;

plan 3;

is(dcbadd(11,1),100,'example 1');
is(dcbadd(101,1),110,'example 2');
is(dcbadd(100,11),111,'example 3');

sub cvradix($n,$r,$tf) {
  my $o=0;
  my $nn=$n;
  my $m=1;
  my $ra;
  my $rb;
  if ($tf==0) { # convert to radix-format
    $ra=$r;
    $rb=10;
  } else { # convert from radix-format
    $ra=10;
    $rb=$r;
  }
  while ($nn > 0) {
    $o+=($nn % $ra)*$m;
    $nn=floor($nn/$ra);
    $m*=$rb;
  }
  return $o;
}

sub dcbadd($a,$b) {
  return cvradix(cvradix($a,2,1)+cvradix($b,2,1),2,0);
}
