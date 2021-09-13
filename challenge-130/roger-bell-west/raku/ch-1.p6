#! /usr/bin/perl6

use Test;

plan 2;

is(on([2,5,4,4,5,5,2]),5,'example 1');
is(on([1,2,3,4,3,2,1,4,4]),4,'example 2');

sub on(@tree) {
  my $k=SetHash.new;
  for @tree -> $n {
    if ($k.{$n}) {
      $k{$n}:delete;
    } else {
      $k{$n}++;
    }
  }
  return ($k.keys)[0];
}
