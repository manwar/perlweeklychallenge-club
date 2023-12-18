#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(mostfrequentletterpair('abcdbca'), 'bc', 'example 1');
is(mostfrequentletterpair('cdeabeabfcdfabgcd'), 'ab', 'example 2');

use List::Util qw(max);

sub mostfrequentletterpair($s) {
  my %f;
  foreach my $i (0 .. length($s) - 2) {
    my $pair = substr($s, $i, 2);
    $f{$pair}++;
  }
  my $m = max(values %f);
  my @l = sort {$a cmp $b} grep {$f{$_} == $m} keys %f;
  return $l[0];
}
