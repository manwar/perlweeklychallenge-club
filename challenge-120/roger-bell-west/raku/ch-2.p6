#! /usr/bin/perl6

use Test;

plan 2;

is(ca('03:10'),35,'example 1');
is(ca('04:00'),120,'example 2');

sub ca($n) {
  my $a=0;
  if ($n ~~ /(<[0..9]>+)\:(<[0..9]>+)/) {
    my ($ha,$ma)=map {$_ % 360}, ($0*30+$1/2,$1*6);
    $a=abs($ha-$ma);
    while ($a > 180) {
      $a-=360;
    }
    $a=abs($a);
  }
  return $a;
}
