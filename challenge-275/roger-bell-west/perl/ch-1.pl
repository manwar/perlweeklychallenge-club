#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(brokenkeys('Perl Weekly Challenge', ['l', 'a']), 0, 'example 1');
is(brokenkeys('Perl and Raku', ['a']), 1, 'example 2');
is(brokenkeys('Well done Team PWC', ['l', 'o']), 2, 'example 3');

sub brokenkeys($a, $k) {
  my $out = 0;
  my %failset = map {lc($_) => 1} @{$k};
  foreach my $word (split ' ', $a) {
    my %wordset = map {$_ => 1} split '',lc($word);
    my @intersect = grep {exists $wordset{$_}} keys %failset;
    if (scalar @intersect == 0) {
      $out++;
    }
  }
  return $out;
}
