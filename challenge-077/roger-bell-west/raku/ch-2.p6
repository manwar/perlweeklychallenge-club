#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(nx(([<O O X>],[<X O O>],[<X O O>])),1,"example 1");
is-deeply(nx(([<O O X O>],[<X O O O>],[<X O O X>],[<O X O O>])),2,"example 2");

sub nx(@n) {
  my $mr=@n.end;
  my $mc=@n[0].end;
  my $isol=0;
  for 0..$mr -> $r {
    for 0..$mc -> $c {
      unless (@n[$r][$c] eq 'X') {
        next;
      }
      my $isolated=1;
      for (-1,0,1) -> $dr {
        if ($r+$dr < 0 || $r+$dr > $mr) {
          next;
        }
        for (-1,0,1) -> $dc {
          if ($dc==0 && $dr==0) {
            next;
          }
          if ($c+$dc < 0 || $c+$dc > $mc) {
            next;
          }
          if (@n[$r+$dr][$c+$dc] eq 'X') {
            $isolated=0;
            last;
          }
        }
      }
      if ($isolated) {
        $isol++;
      }
    }
  }
  return $isol;
}