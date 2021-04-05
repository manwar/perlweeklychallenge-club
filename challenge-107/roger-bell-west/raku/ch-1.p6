#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(sdn(3),[1210, 2020, 21200],'example 1');

sub sdn($count) {
  my @r;
  my $n=10;
  while (@r.elems < $count) {
    my @ns=map {$_+0}, sprintf('%d',$n).comb;
    my @d=(0) xx 10;
    map {@d[$_]++},@ns;
    my $sd=1;
    for 0..@ns.elems-1 -> $i {
      if (@d[$i] != @ns[$i]) {
        $sd=0;
        last;
      }
    }
    if ($sd && @ns.elems < 9) {
      for @ns.elems..9 -> $i {
        if (@d[$i] != 0) {
          $sd=0;
          last;
        }
      }
    }
    if ($sd) {
      push @r,$n;
    }
    $n+=10;
  }
  return @r;
}

