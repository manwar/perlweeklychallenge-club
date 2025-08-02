#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(cleardigits('cab12'), 'c', 'example 1');
is(cleardigits('xy99'), '', 'example 2');
is(cleardigits('pa1erl'), 'perl', 'example 3');

sub cleardigits($a) {
  my @out;
  foreach my $c (split '', $a) {
    if ($c =~ /\d/) {
      pop @out;
    } else {
      push @out, $c;
    }
  }
  join('', @out);
}
