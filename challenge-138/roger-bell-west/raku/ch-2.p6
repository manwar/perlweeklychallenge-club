#! /usr/bin/perl6

use Test;

plan 3;

is(splnum(81),1,'example 1');
is(splnum(9801),1,'example 2');
is(splnum(36),0,'example 3');

sub splnum($n) {
  my $k=floor(sqrt($n));
  if ($k*$k != $n) {
    return 0;
  }
  my @d=$n.comb;
  for (1..(1 +< (@d.end))-1) -> $s {
    my @s=(0);
    for (0..@d.end-1) -> $i {
      if ($s +& (1 +< $i)) {
        push @s,$i+1;
      }
    }
    push @s,@d.end+1;
    my $c=0;
    for (0..@s.end-1) -> $j {
      $c+=join('',@d[@s[$j]..@s[$j+1]-1]);
    }
    if ($c == $k) {
      return 1;
    }
  }
  return 0;
}
