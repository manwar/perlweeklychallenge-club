#! /usr/bin/perl6

use Test;

plan 2;

is(ts([[1],[2,4],[6,4,9],[5,1,7,2]]),8,'example 1');
is(ts([[3],[3,1],[5,2,3],[4,3,1,3]]),7,'example 2');

sub ts($in) {
  my @b;
  my $n=0;
  my $i=0;
  my $s=$in[0][0];
  my @r;
  while (1) {
    if (@b.elems > 0) {
      my $t=@b.pop;
      ($n,$i,$s)=$t;
    }
    if ($n < $in.elems-1) {
      $n++;
      for ($i,$i+1) -> $ix {
        push @b,[$n,$ix,$s+$in[$n][$ix]];
      }
    } else {
      push @r,$s;
    }
    unless (@b) {
      last;
    }
  }
  return min(@r);
}
