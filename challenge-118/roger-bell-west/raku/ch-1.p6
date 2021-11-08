#! /usr/bin/perl6

use Test;

plan 2;

is(bp(5),1,'example 1');
is(bp(4),0,'example 2');

sub bp($n) {
  my @s=sprintf('%b',$n).comb;
  my $l=@s.elems-1;
  for 0..floor($l/2) -> $i {
    if (@s[$i] ne @s[$l-$i]) {
      return 0;
    }
  }
  return 1;
}
