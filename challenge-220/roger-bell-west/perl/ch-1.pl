#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(commoncharacters(['Perl', 'Rust', 'Raku']), ['r'], 'example 1');
is_deeply(commoncharacters(['love', 'live', 'leave']), ['e', 'l', 'v'], 'example 2');

sub word2set($word) {
  return {map {$_ => 1} grep /[a-z]/, split '', lc($word)};
}

sub commoncharacters($lst) {
  my $c = word2set($lst->[0]);
  foreach my $si (1 .. $#{$lst}) {
    my $d = word2set($lst->[$si]);
    foreach my $l (keys %{$c}) {
      unless (exists $d->{$l}) {
        delete $c->{$l};
      }
    }
  }
  return [sort keys %{$c}];
}
