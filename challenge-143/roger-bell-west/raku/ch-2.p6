#! /usr/bin/perl6

use Test;
plan 3;

is(is_stealthy(36),True,'example 1');
is(is_stealthy(12),True,'example 2');
is(is_stealthy(6),False,'example 3');

sub factorpairs($n) {
  if ($n==1) {
    return [2];
  }
  my @ff;
  my $s=floor(sqrt($n));
  if ($s*$s == $n) {
    push @ff,$s*2;
    $s--;
  }
  for (2..$s) -> $pf {
    if ($n % $pf == 0) {
      push @ff,$pf+($n div $pf);
    }
  }
  push @ff,1+$n;
  return @ff;
}

sub is_stealthy($n) {
  my @p=factorpairs($n);
  if (@p.elems==1) {
    return False;
  }
  for (0..@p.end-1) -> $ix {
    for ($ix+1..@p.end) -> $iy {
      if (abs(@p[$ix]-@p[$iy])==1) {
        return True;
      }
    }
  }
  return False;
}
