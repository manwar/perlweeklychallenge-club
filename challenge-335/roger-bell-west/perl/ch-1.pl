#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(commoncharacters(['bella', 'label', 'roller']), ['e', 'l', 'l'], 'example 1');
is_deeply(commoncharacters(['cool', 'lock', 'cook']), ['c', 'o'], 'example 2');
is_deeply(commoncharacters(['hello', 'world', 'pole']), ['l', 'o'], 'example 3');
is_deeply(commoncharacters(['abc', 'def', 'ghi']), [], 'example 4');
is_deeply(commoncharacters(['aab', 'aac', 'aaa']), ['a', 'a'], 'example 5');

use List::Util qw(min);

sub commoncharacters($a) {
  my %mc;
  my $first = 1;
  foreach my $s (@{$a}) {
    my %mk;
    map {$mk{$_}++} split '',$s;
    if ($first) {
      %mc = %mk;
      $first = 0;
    } else {
      foreach my $k (keys %mc) {
        if (exists $mk{$k}) {
          $mc{$k} = min($mc{$k}, $mk{$k});
        } else {
          delete $mc{$k};
        }
      }
    }
  }
  my @out;
  foreach my $c (sort keys %mc) {
    foreach (1 .. $mc{$c}) {
      push @out, $c;
    }
  }
  \@out;
}
