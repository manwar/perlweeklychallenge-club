#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 7;

is(validnumber('1'), 1, 'example 1');
is(validnumber('a'), 0, 'example 2');
is(validnumber('.'), 0, 'example 3');
is(validnumber('1.2e4.2'), 0, 'example 4');
is(validnumber('-1.'), 1, 'example 5');
is(validnumber('+1E-8'), 1, 'example 6');
is(validnumber('.44'), 1, 'example 7');

sub validnumber($a) {
  my $integer = '[-+]?[0-9]+';
  my $float = '[-+]?([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)';
  my $exponential =
    '(' . $integer . '|' . $float . ')[Ee]' . $integer;
  my $number =
    '^(' . $integer . '|' . $float . '|' . $exponential . ')$';
  if ($a =~ /$number/) {
    return 1;
  } else {
    return 0;
  }
}
