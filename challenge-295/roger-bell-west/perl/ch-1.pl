#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(wordbreak('weeklychallenge', ['challenge', 'weekly']), 1, 'example 1');
is(wordbreak('perlrakuperl', ['raku', 'perl']), 1, 'example 2');
is(wordbreak('sonsanddaughters', ['sons', 'sand', 'daughters']), 0, 'example 3');

sub wordbreak($a, $words) {
  my @queue = ($a);
  while ($#queue >= 0) {
    my $remnant = shift @queue;
    if (length($remnant) == 0) {
      return 1;
    }
    foreach my $candidate (@{$words}) {
      if (index($remnant, $candidate) == 0) {
        push @queue, substr($remnant, length($candidate));
      }
    }
  }
  0;
}
