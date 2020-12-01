#! /usr/bin/perl6

use Test;
plan 2;

is(gs(3),3,'example 1');
is(gs(4),7,'example 2');

sub gs($n) {
  my $tot=$n-1; # gcd(1,2)+gcd(1,3)+...+gcd(1,n)
  for (2..$n-1) -> $a {
    $tot+=sum(map {gcd($a,$_)},($a+1..$n));
  }
  return $tot;
}

sub gcd($ai,$bi) {
  my ($a,$b)=($ai,$bi);
  if ($a==0) {
    return $b;
  }
  if ($b==0) {
    return $a;
  }
  my $d=0;
  while (1) {
    if ($a == $b) {
      return $a +< $d;
    }
    my $aa=($a % 2 == 0);
    my $bb=($b % 2 == 0);
    if ($aa ?& $bb) {
      $a +>= 1;
      $b +>= 1;
      $d++;
    } elsif ($aa) {
      $a +>= 1;
    } elsif ($bb) {
      $b +>= 1;
    } else {
      my $c=abs($a-$b);
      $a=min($a,$b);
      $b=$c +> 1;
    }
  }
}
