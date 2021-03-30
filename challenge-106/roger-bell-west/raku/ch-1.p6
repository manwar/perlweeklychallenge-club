#! /usr/bin/perl6

use Test;

plan 3;

is(mg(2,9,3,5),4,'example 1');
is(mg(1,3,8,2,0),5,'example 2');
is(mg(5),0,'example 3');

sub mg(**@aa) {
  my @a=@aa.sort;
  my $g=0;
  for (0..@a.elems-2) -> $i {
    my $d=abs(@a[$i]-@a[$i+1]);
    if ($d>$g) {
      $g=$d;
    }
  }
  return $g;
}
