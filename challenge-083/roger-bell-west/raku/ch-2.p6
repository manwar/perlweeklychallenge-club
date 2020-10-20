#! /usr/bin/perl6

use Test;
plan 3;

is(fa(3,10,8),1,'example 1');
is(fa(12,2,10),1,'example 2');
is(fa(2,2,10),2,'example 3');

sub fa(**@a) {
  my $ss=sum(@a);
  my $ls;
  my $li;
  for @a.combinations(1..@a.elems) -> $l {
    my $s=$ss-2*sum($l);
    if ($s >= 0) {
      if ((!defined $ls) || $s < $ls || ($ls == $s && $l.elems < $li)) {
        $ls=$s;
        $li=$l.elems;
      }
    }
  }
  return $li;
}
