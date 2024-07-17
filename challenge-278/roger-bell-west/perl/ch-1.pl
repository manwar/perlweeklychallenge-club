#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(sortstring('and2 Raku3 cousins5 Perl1 are4'), 'Perl and Raku are cousins', 'example 1');
is(sortstring('guest6 Python1 most4 the3 popular5 is2 language7'), 'Python is the most popular guest language', 'example 2');
is(sortstring('Challenge3 The1 Weekly2'), 'The Weekly Challenge', 'example 3');

sub sortstring($a) {
  my @words = split ' ', $a;
  my @out = ("") x scalar @words;
  foreach my $w (@words) {
    $w =~ /^(.*?)([0-9]+)$/;
    @out[$2 - 1] = $1;
  }
  return join(' ', @out);
}
