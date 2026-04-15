#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(groupdivision('RakuPerl', 4, '*'), ['Raku', 'Perl'], 'example 1');
is_deeply(groupdivision('Python', 5, '0'), ['Pytho', 'n0000'], 'example 2');
is_deeply(groupdivision('12345', 3, 'x'), ['123', '45x'], 'example 3');
is_deeply(groupdivision('HelloWorld', 3, '_'), ['Hel', 'loW', 'orl', 'd__'], 'example 4');
is_deeply(groupdivision('AI', 5, '!'), ['AI!!!'], 'example 5');

sub groupdivision($a0, $sz, $pad) {
  my $a = $a0;
  while (length($a) % $sz != 0) {
    $a .= $pad;
  }
  my $re = '(' . '.' x $sz . ')';
  [$a =~ /$re/g];
}
