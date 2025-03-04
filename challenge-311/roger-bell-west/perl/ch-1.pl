#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(upperlower('pERL'), 'Perl', 'example 1');
is(upperlower('rakU'), 'RAKu', 'example 2');
is(upperlower('PyThOn'), 'pYtHoN', 'example 3');

sub upperlower($a) {
  my $out = '';
  foreach my $c (split '',$a) {
    $out .= chr(ord($c) ^ 32);
  }
  $out;
}
