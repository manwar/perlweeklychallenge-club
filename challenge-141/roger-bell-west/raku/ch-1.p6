#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(divisors(8,10),[24,30,40,42,54,56,66,70,78,88],'example 1');

sub factorcount($n) {
  if ($n==1) {
    return 1;
  }
  my $f=2;
  my $s=floor(sqrt($n));
  if ($s*$s == $n) {
    $s--;
    $f+=1;
  }
  for (2..$s) -> $pf {
    if ($n % $pf == 0) {
      $f+=2;
    }
  }
  return $f;
}

sub divisors($count,$n) {
  my $nn=$n;
  my @a;
  my $t=0;
  while ($nn) {
    $t++;
    if (factorcount($t)==$count) {
      push @a,$t;
      $nn--;
    }
  }
  return @a;
}
