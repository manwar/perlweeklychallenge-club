#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(thousandseparator(123), '123', 'example 1');
is(thousandseparator(1234), '1,234', 'example 2');
is(thousandseparator(1000000), '1,000,000', 'example 3');
is(thousandseparator(1), '1', 'example 4');
is(thousandseparator(12345), '12,345', 'example 5');

sub thousandseparator($a) {
  my $out = "";
  my @s = split '', $a;
  my $offset = 2 - ((2 + scalar @s) % 3);
  while (my ($i, $d) = each @s) {
    if ($i > 0 && ($i + $offset) % 3 == 0) {
      $out .= ',';
    }
    $out .= $d; 
  }
  $out;
}
