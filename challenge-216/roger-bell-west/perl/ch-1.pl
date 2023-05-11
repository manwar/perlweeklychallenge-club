#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(registrationnumber(['abc', 'abcd', 'bcd'], 'AB1 2CD'), ['abcd'], 'example 1');
is_deeply(registrationnumber(['job', 'james', 'bjorg'], '007 JB'), ['job', 'bjorg'], 'example 2');
is_deeply(registrationnumber(['crack', 'road', 'rac'], 'C7 RA2'), ['crack', 'rac'], 'example 3');

use Storable qw(dclone);

sub word2set($word) {
  return {map {$_ => 1} grep /[a-z]/, split '', lc($word)};
}

sub registrationnumber($words, $reg) {
  my $s = word2set($reg);
  my @out;
  foreach my $w (@{$words}) {
    my $ss = dclone($s);
    foreach my $char (keys %{word2set($w)}) {
      if (exists $ss->{$char}) {
        delete $ss->{$char};
        if (scalar %{$ss} == 0) {
          push @out, $w;
          last;
        }
      }
    }
  }
  return \@out;
}
