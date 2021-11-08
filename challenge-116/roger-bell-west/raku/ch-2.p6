#! /usr/bin/perl6

use Test;

plan 3;

is(sos(34),1,'example 1');
is(sos(50),1,'example 2');
is(sos(52),0,'example 3');

sub sos($n) {
  my $t=0;
  for $n.comb() {
    $t+=$_*$_;
  }
  my $s=floor(sqrt($t));
  if ($s*$s==$t) {
    return 1;
  }
  return 0;
}
