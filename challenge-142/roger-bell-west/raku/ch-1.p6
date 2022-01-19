#! /usr/bin/perl6

use Test;

plan 2;

is(dld(24,2),2,'example 1');
is(dld(30,5),2,'example 2');

sub factor($n) {
  if ($n==1) {
    return [1];
  }
  my @ff;
  my $s=floor(sqrt($n));
  if ($s*$s == $n) {
    push @ff,$s;
    $s--;
  }
  for (2..$s) -> $pf {
    if ($n % $pf == 0) {
      unshift @ff,$pf;
      push @ff,$n div $pf;
    }
  }
  return @ff;
}

sub dld($m,$n) {
  return elems(grep {$_ % 10 == $n}, factor($m));
}
