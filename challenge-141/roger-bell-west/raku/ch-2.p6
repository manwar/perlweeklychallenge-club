#! /usr/bin/perl6

use Test;

plan 2;

is(likenumber(1234,2),9,'example 1');
is(likenumber(768,4),3,'example 2');

sub likenumber($source,$factor) {
  my @s=$source.comb;
  my $m=@s.elems;
  my $n=0;
  for (1..(1 +< $m)-2) -> $mask {
    my $c=0;
    for (0..$m-1) -> $di {
      if ($mask +& (1 +< $di)) {
        $c=$c*10+@s[$di];
      }
    }
    if ($c % $factor == 0) {
      $n++;
    }
  }
  return $n;
}
