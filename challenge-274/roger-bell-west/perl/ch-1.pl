#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(goatlatin('I love Perl'), 'Imaa ovelmaaa erlPmaaaa', 'example 1');
is(goatlatin('Perl and Raku are friends'), 'erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa', 'example 2');
is(goatlatin('The Weekly Challenge'), 'heTmaa eeklyWmaaa hallengeCmaaaa', 'example 3');

sub goatlatin($a) {
  my @out;
  my @w = split ' ', $a;
  while (my ($ix, $word) = each @w) {
    my @c = split '',$word;
    my $nw = $word;
    if ($c[0] !~ /[aeiou]/i) {
      push @c,shift @c;
      $nw = join('', @c);
    }
    $nw .= 'ma';
    $nw .= 'a' x ($ix + 1);
    push @out, $nw;
  }
  return join(' ', @out);
}
