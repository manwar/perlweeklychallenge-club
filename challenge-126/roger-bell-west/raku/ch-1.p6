#! /usr/bin/perl6

use Test;

plan 4;

is(cn(15),8,'example 1');
is(cn(25),13,'example 2');
is(cn(10000),6560,'example 3');
is(cn(100000000),43046720,'example 4');

sub cn($n) {
  my $k=$n;
  my @digits;
  while ($k>0) {
    my $d=$k%10;
    if ($d==1) {
      @digits=(8) xx @digits.elems;
    }
    if ($d>0) {
      $d--;
    }
    push @digits,$d;
    $k=floor($k/10);
  }
  my $tc=0;
  for (0..@digits.end).reverse() -> $i {
    $tc*=9;
    $tc+=@digits[$i];
  }
  return $tc;
}
