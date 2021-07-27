#! /usr/bin/perl6

use Test;

plan 3;

is(un(7),8,'example 1');
is(un(10),12,'example 2');
is(un(200),16200,'example 3');

sub un($m) {
  my $n;
  my @s=([1],[1],[1]);
  my @c=(2,3,5);
  for (1..$m) {
    $n=min(@s[0][0],@s[1][0],@s[2][0]);
    for 0..2 -> $i {
      if (@s[$i][0] == $n) {
        shift @s[$i];
      }
      push @s[$i],$n*@c[$i];
    }
  }
  return $n;
}
