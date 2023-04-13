#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(jumpingletters('Perl', [2, 22, 19, 9]), 'Raku', 'example 1');
is(jumpingletters('Raku', [24, 4, 7, 17]), 'Perl', 'example 2');

sub jumpingletters($word, $jump) {
  my @s = '';
  my $i = 0;
  foreach my $c (split '', $word) {
    my $d = ord($c) + $jump->[$i] % 26;
    if (($c le 'Z' && $d > 90) || $d > 122) {
      $d -= 26;
    }
    push @s,chr($d);
    $i++;
  }
  return join('', @s);
}
