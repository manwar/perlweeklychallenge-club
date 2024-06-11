#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 6;

is(percentageofcharacter('perl', 'e'), 25, 'example 1');
is(percentageofcharacter('java', 'a'), 50, 'example 2');
is(percentageofcharacter('python', 'm'), 0, 'example 3');
is(percentageofcharacter('ada', 'a'), 67, 'example 4');
is(percentageofcharacter('ballerina', 'l'), 22, 'example 5');
is(percentageofcharacter('analitik', 'k'), 13, 'example 6');

use integer;
sub percentageofcharacter($a, $c) {
  my $d = length($a);
  my $n = 0;
  while ($a =~ /$c/g) {
    $n++;
  }
  $n *= 100;
  return ($n + $d / 2) / $d;
}
