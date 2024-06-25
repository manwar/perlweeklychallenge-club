#! /usr/bin/raku

use Test;

plan 4;

is(replacedigits('a1c1e1'), 'abcdef', 'example 1');
is(replacedigits('a1b2c3d4'), 'abbdcfdh', 'example 2');
is(replacedigits('b2b'), 'bdb', 'example 3');
is(replacedigits('a16z'), 'abgz', 'example 4');

sub replacedigits($a) {
  my @out;
  my $prev = 0;
  for $a.comb -> $c {
    if ($c ge '0' && $c le '9') {
      @out.push(chr($prev + $c));
    } else {
      $prev = ord($c);
      @out.push($c);
    }
  }
  return @out.join('');
}
