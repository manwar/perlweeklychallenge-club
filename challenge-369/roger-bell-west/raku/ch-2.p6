#! /usr/bin/raku

use Test;

plan 5;

is-deeply(groupdivision('RakuPerl', 4, '*'), ['Raku', 'Perl'], 'example 1');
is-deeply(groupdivision('Python', 5, '0'), ['Pytho', 'n0000'], 'example 2');
is-deeply(groupdivision('12345', 3, 'x'), ['123', '45x'], 'example 3');
is-deeply(groupdivision('HelloWorld', 3, '_'), ['Hel', 'loW', 'orl', 'd__'], 'example 4');
is-deeply(groupdivision('AI', 5, '!'), ['AI!!!'], 'example 5');

sub groupdivision($a0, $sz, $pad) {
  my $a = $a0;
  while ($a.chars % $sz != 0) {
    $a ~= $pad;
  }
  $a.comb.rotor($sz).map({$_.join('')}).Array;
}
