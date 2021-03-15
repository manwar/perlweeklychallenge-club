#! /usr/bin/perl6

use Test;

plan 3;

is(game(),1,'example 1');
is(game(10),0,'example 2');
is(game(14),0,'example 3');

multi game {
  return game(12);
}

multi game($hh) {
  my $heap=$hh;
  my @players=('Alice','Bob');
  my $a=0;
  while ($heap>0) {
    my $n=play($heap);
    $heap-=$n;
    note "@players[$a] takes $n leaving $heap.";
    if ($heap==0) {
      note "@players[$a] wins.";
      last;
    }
    $a++;
    $a %= 2;
  }
  return $a;
}

sub play($state) {
  my $m=$state % 4;
  if ($m==0) {
    return floor(rand*3)+1;
  } else {
    return $m;
  }
}
