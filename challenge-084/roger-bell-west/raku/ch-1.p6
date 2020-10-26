#! /usr/bin/perl6

use Test;

plan 3;

is(ri(1234),4321,'example 1');
is(ri(-1234),-4321,'example 2');
is(ri(1231230512),0,'example 3');

sub ri(Int $s) {
  my $r=$s.comb.reverse.join('');
  if ($r ~~ /(<[0..9]>+)\-$/) {
    $r="-$0";
  }
  my int32 $b=Int($r);
  if ($b != $r) {
    return 0;
  }
  return $r;
}
