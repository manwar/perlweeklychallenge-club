#! /usr/bin/raku

use Test;

plan 2;

is-deeply(aliendictionary(['perl', 'python', 'raku'], ['h', 'l', 'a', 'b', 'y', 'd', 'e', 'f', 'g', 'i', 'r', 'k', 'm', 'n', 'o', 'p', 'q', 'j', 's', 't', 'u', 'v', 'w', 'x', 'c', 'z']), ['raku', 'python', 'perl'], 'example 1');
is-deeply(aliendictionary(['the', 'weekly', 'challenge'], ['c', 'o', 'r', 'l', 'd', 'a', 'b', 't', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'm', 'n', 'p', 'q', 's', 'w', 'u', 'v', 'x', 'y', 'z']), ['challenge', 'the', 'weekly'], 'example 2');

sub aliendictionary(@a, @dc) {
  my $mxl = @a.map({$_.chars}).max;
  my %dh;
  for @dc.kv -> $i, $c {
    %dh{$c} = $i + 1;
  }
  my @b = @a;
  my %numerics;
  for @b -> $w {
    my $n = 0;
    my @cc = $w.comb;
    for 0 ..^ $mxl -> $i {
      $n *= 27;
      if ($i < $w.chars) {
        $n += %dh{@cc[$i]};
      }
    }
    %numerics{$w} = $n;
  }
  @b = @b.sort({ %numerics{$^a} <=> %numerics{$^b} });
  return @b;
}
