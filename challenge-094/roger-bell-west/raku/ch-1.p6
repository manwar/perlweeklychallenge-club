#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(ga('opt','bat','saw','tab','pot','top','was'),Set.new(Set.new('bat','tab'),Set.new('opt','pot','top'),Set.new('saw','was')),'example 1');
is-deeply(ga('x'),Set.new(Set.new('x')),'example 2');

sub ga(**@in) {
  my %g;
  for @in -> $word {
    push %g{wh($word)},$word;
  }
  return Set(map {Set($_)}, %g.values);
}

sub wh($word) {
  my $w=lc($word);
  if ($w ~~ /<-[a..z]>/) {
    return 0;
  }
  my $b='a'.ord;
  my @p=(2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101);
  my $n=1;
  for $w.comb(/./) -> $c {
    $n*=@p[$c.ord-$b];
  }
  return $n;
}
