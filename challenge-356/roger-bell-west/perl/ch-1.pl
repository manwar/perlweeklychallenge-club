#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(magicalstring(4), 2, 'example 1');
is(magicalstring(5), 3, 'example 2');
is(magicalstring(6), 3, 'example 3');
is(magicalstring(7), 4, 'example 4');
is(magicalstring(8), 4, 'example 5');

sub magicalstring($a) {
  my @s = (0) * ($a * 2);
  $s[0] = 1;
  my $l = 1;
  my $n = 0;
  my $ic = 0;
  while ($ic < $a) {
    if ($s[$n] == 2) {
      $s[$ic + 1] = $l;
      $ic++;
    }
    $l = 3 - $l;
    $ic++;
    $s[$ic] = $l;
    $n++;
  }
  splice @s, $a;
  scalar grep {$_ == 1} @s;
}
