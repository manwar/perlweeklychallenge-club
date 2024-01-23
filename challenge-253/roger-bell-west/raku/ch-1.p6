#! /usr/bin/raku

use Test;

plan 2;

is-deeply(splitstrings(['one.two.three', 'four.five', 'six'], '.'), ['one', 'two', 'three', 'four', 'five', 'six'], 'example 1');
is-deeply(splitstrings(['$perl$$', '$$raku$'], '$'), ['perl', 'raku'], 'example 2');

sub splitstrings(@a, $ssep) {
  my @p;
  my $sep = $ssep;
  $sep ~~ s:g/(<[^A..Z0..9]>)/\\$1/;
  for @a -> $s {
    @p.append($s.split($sep).grep(/./));
  }
  return @p;
}
