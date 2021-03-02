#! /usr/bin/perl6

use Test;

plan 5;

is(hcs(1),'#','example 1');
is(hcs(2),'2#','example 2');
is(hcs(3),'#3#','example 3');
is(hcs(10),'#3#5#7#10#','example 4');
is(hcs(14),'2#4#6#8#11#14#','example 5');

sub hcs($n) {
  my @s;
  my @t;
  while (1) {
    @s=();
    my $l=0;
    if (@t.elems) {
      @s=(pop @t).flat;
      $l=sum(map {($_==1 ?? 0 !! chars($_))+1}, @s);
    }
    if ($l==$n) {
      last;
    }
    if ($l > $n) {
      next;
    }
    my $c=$l;
    while (1) {
      my $tt=($c==1 ?? 0 !! chars($c))+$l+1;
      if ($c==$tt) {
        my @k=(@s».List.flat);
        push @k,$c;
        push @t,@k;
      }
      if ($c > $tt) {
        last;
      }
      $c++;
    }
  }
  return join('',map {($_==1 ?? '' !! $_) ~ '#'}, @s);
}
