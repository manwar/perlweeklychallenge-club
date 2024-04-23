#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(uncommonwords('Mango is sweet', 'Mango is sour'), ['sweet', 'sour'], 'example 1');
is_deeply(uncommonwords('Mango Mango', 'Orange'), ['Orange'], 'example 2');
is_deeply(uncommonwords('Mango is Mango', 'Orange is Orange'), [], 'example 3');

sub getlistset($a) {
  my @la = split ' ', $a;
  my %ca;
  map {$ca{$_}++} @la;
  @la = grep {$ca{$_} == 1} @la;
  return (\@la, \%ca);
}

sub uncommonwords($a, $b) {
  my ($la, $sa) = getlistset($a);
  my ($lb, $sb) = getlistset($b);
  my @out;
  foreach my $r ([$la, $sb], [$lb, $sa]) {
    my ($wl, $t) = @{$r};
    foreach my $w (@{$wl}) {
      unless (exists $t->{$w}) {
        push @out, $w;
      }
    }
  }
  return \@out;
}
