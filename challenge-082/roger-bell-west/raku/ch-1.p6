#! /usr/bin/perl6

use Test;

plan 5;

is-deeply(factor(12),SetHash.new(1,2,3,4,6,12),'twelve');
is-deeply(factor(18),SetHash.new(1,2,3,6,9,18),'eighteen');
is-deeply(factor(23),SetHash.new(1,23),'twenty-three');

is-deeply(commonfactor(12,18),(1,2,3,6),'twelve-eighteen');
is-deeply(commonfactor(18,23),(1,),'twelve-twentythree');

sub factor($n) {
  my $o=SetHash.new(1,$n);
  for 2..floor(sqrt($n)) -> $i {
    if ($n % $i == 0) {
      $o{Int.new($n/$i)}++;
      $o{$i}++;
    }
  }
  return $o;
}

sub commonfactor {
  my @f=map {factor($_)},@_;
  my $s=shift @f;
  while (@f) {
    $s (&)= shift @f;
  }
  return $s.keys.sort;
}
