#! /usr/bin/perl6

use Test;

plan 4;

is(sip([1,2,3,4],3),2,'example 1');
is(sip([1,3,5,7],6),3,'example 2');
is(sip([12,14,16,18],10),0,'example 3');
is(sip([11,13,15,17],19),4,'example 4');

sub sip(@n,$t) {
  if (@n.tail < $t) {
    return @n.elems;
  }
  my ($l,$h)=(0,@n.elems-1);
  while ($h-$l > 1) {
    my $m=floor(($h+$l)/2);
    if (@n[$m] == $t) {
      return $m;
    } elsif (@n[$m] > $t) {
      $h=$m;
    } else {
      $l=$m;
    }
  }
  if (@n[$l] >= $t) {
    return $l;
  }
  return $h;
}
