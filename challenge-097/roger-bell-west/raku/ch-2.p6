#! /usr/bin/perl6

use Test;

plan 2;

is(bs('101100101',3),1,'example 1');
is(bs('00011011',2),4,'example 2');

sub bs($b,$s) {
  my @bb=$b.comb($s);
  if (chars(@bb[@bb.end]) != $s) {
    return -1;
  }
  my $mc=-1;
  my %cost;
  for (0..@bb.end-1) -> $x {
    %cost{$x}{$x}=0;
    for ($x+1..@bb.end) -> $y {
      %cost{$x}{$y}=%cost{$y}{$x}=diff(@bb[$x],@bb[$y]);
    }
    my $tc=sum(map {%cost{$x}{$_}},0..@bb.end);
    if ($mc==-1 || $tc < $mc) {
      $mc=$tc;
    }
  }
  return $mc;
}

sub diff($a,$b) {
  my @ac=$a.comb;
  my @bc=$b.comb;
  my $d=0;
  for (0..@ac.end) -> $i {
    if (@ac[$i] ne @bc[$i]) {
      $d++;
    }
  }
  return $d;
}
