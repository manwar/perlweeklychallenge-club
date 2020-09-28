#! /usr/bin/perl6

use Test;

plan 3;

is(spn((5,2,-2,0)),1,'example 1');
is(spn((1,8,-1)),2,'example 2');
is(spn((2,0,-1)),1,'example 3');

sub spn(@list) {
  my $r=set grep {$_ > 0}, @list;
  my $m=1;
  while ($r{$m}:exists) {
    $m++;
  }
  return $m;
}
