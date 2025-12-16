#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(matchstring(['cat', 'cats', 'dog', 'dogcat', 'dogcat', 'rat', 'ratcatdogcat']), ['cat', 'dog', 'dogcat', 'rat'], 'example 1');
is_deeply(matchstring(['hello', 'hell', 'world', 'wor', 'ellow', 'elloworld']), ['hell', 'world', 'wor', 'ellow'], 'example 2');
is_deeply(matchstring(['a', 'aa', 'aaa', 'aaaa']), ['a', 'aa', 'aaa'], 'example 3');
is_deeply(matchstring(['flower', 'flow', 'flight', 'fl', 'fli', 'ig', 'ght']), ['flow', 'fl', 'fli', 'ig', 'ght'], 'example 4');
is_deeply(matchstring(['car', 'carpet', 'carpenter', 'pet', 'enter', 'pen', 'pent']), ['car', 'pet', 'enter', 'pen', 'pent'], 'example 5');

sub matchstring($a) {
  my @out;
  my %s;
  foreach my $x (@{$a}) {
    unless (exists $s{$x}) {
      foreach my $y (@{$a}) {
        if (length($y) > length($x) && index($y, $x) >= 0) {
          push @out, $x;
          last;
        }
      }
      $s{$x} = 1;
    }
  }
  \@out;
}
