#! /usr/bin/perl6

use Test;

plan 2;

is(sp(1,2,-1,3,4),13,'example 1');
is(sp(1,2,3,4,-1,5,6),26,'example 2');

sub sp (**@t) {
  my $s=0;
  my @path=((0));
  while (@path) {
    my $a=shift @path;
    my $c=($a[$a.end]+1)*2-1;
    my $tn=1;
    for ($c,$c+1) -> $ac {
      if ($ac <= @t.end && @t[$ac] != -1) {
        push @path,($a.flat,$ac).flat.list;
        $tn=0;
      }
    }
    if ($tn) {
      $s+=sum(map {@t[$_]},$a.list);
    }
  }
  return $s;
}
