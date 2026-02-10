#! /usr/bin/raku

use Test;

plan 6;

is(textjustifier('Hi', 5), '*Hi**', 'example 1');
is(textjustifier('Code', 10), '***Code***', 'example 2');
is(textjustifier('Hello', 9), '**Hello**', 'example 3');
is(textjustifier('Perl', 4), 'Perl', 'example 4');
is(textjustifier('A', 7), '***A***', 'example 5');
is(textjustifier('', 5), '*****', 'example 6');

sub textjustifier($intxt, $width) {
  my @working = '*' xx $width;
  my $offset = floor(($width - $intxt.chars) / 2);
  for $intxt.comb.kv -> $i, $c {
    @working[$i + $offset] = $c;
  }
  @working.join('');
}
