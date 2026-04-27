#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(scramblestring('abc', 'acb'), 1, 'example 1');
is(scramblestring('abcd', 'cdba'), 1, 'example 2');
is(scramblestring('hello', 'hiiii'), 0, 'example 3');
is(scramblestring('ateer', 'eater'), 1, 'example 4');
is(scramblestring('abcd', 'bdac'), 0, 'example 5');

sub scram($a) {
  if (length($a) < 2) {
    return [$a];
  }
  my @out;
  foreach my $sp (1 .. length($a) - 1) {
    my $suba = scram(substr($a, 0, $sp));
    my $subb = scram(substr($a, $sp));
   foreach my $na (@{$suba}) {
      foreach my $nb (@{$subb}) {
        push @out, $na . $nb;
        push @out, $nb . $na;
      }
    }
  }
  \@out;
}

sub scramblestring($a, $b) {
  my %out = map {$_ => 1} @{scram($a)};
  if (exists $out{$b}) {
    1;
  } else {
    0;
  }
}

