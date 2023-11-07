#! /usr/bin/raku

use Test;

plan 2;

is-deeply(missingmembers([1, 2, 3], [2, 4, 6]), [[1, 3], [4, 6]], 'example 1');
is-deeply(missingmembers([1, 2, 3, 3], [1, 1, 2, 2]), [[3], []], 'example 2');

sub halfmissing(@a, $bh) {
  return @a.grep({$bh{$_}:!exists}).unique.Array;
}

sub missingmembers(@a, @b) {
  my $ah = @a.Set;
  my $bh = @b.Set;
  return [
    halfmissing(@a, $bh),
    halfmissing(@b, $ah),
      ];
}
