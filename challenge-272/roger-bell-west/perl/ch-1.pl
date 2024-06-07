#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(defrangip('1.1.1.1'), '1[.]1[.]1[.]1', 'example 1');
is(defrangip('255.101.1.0'), '255[.]101[.]1[.]0', 'example 2');

sub defrangip($a) {
  (my $b = $a) =~ s/\./[.]/g;
  return $b;
}
