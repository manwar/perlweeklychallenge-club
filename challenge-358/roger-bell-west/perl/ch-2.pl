#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(encryptedstring('abc', 1), 'bcd', 'example 1');
is(encryptedstring('xyz', 2), 'zab', 'example 2');
is(encryptedstring('abc', 27), 'bcd', 'example 3');
is(encryptedstring('hello', 5), 'mjqqt', 'example 4');
is(encryptedstring('perl', 26), 'perl', 'example 5');

sub posmod($x, $y) {
  my $z = $x % $y;
  while ($z < 0) {
    $z += $y;
  }
  $z;
}

sub rotx($a, $offset) {
  my $o = posmod($offset, 26);
  my $base;
  if ($a ge 'a' && $a le 'z') {
    $base = ord('a');
  } elsif ($a ge 'A' && $a le 'Z') {
    $base = ord('A');
  } else {
    return $a;
  }
  my $c = posmod(ord($a) - $base + $o, 26) + $base;
  chr($c);
}

sub encryptedstring($a, $offset) {
  join('', map {rotx($_, $offset)} split '', $a);
}
