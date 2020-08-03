#! /usr/bin/perl6

use Test;

plan 5;

is(zerofact(10),2,'ten');
is(zerofact(7),1,'seven');
is(zerofact(4),0,'four');
is(zerofact(69),15,'sixty-nine');
is(zerofact(125),31,'one hundred and twenty-five');

sub zerofact($n) {
  my $k=5;
  my $t;
  my $a=0;
  repeat {
    $a=floor($n/$k);
    $t+=$a;
    $k*=5;
  } while ($a>0);
  return $t;
}
