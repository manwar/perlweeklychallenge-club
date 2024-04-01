#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(dictionaryrank('CAT'), 3, 'example 1');
is(dictionaryrank('GOOGLE'), 88, 'example 2');
is(dictionaryrank('SECRET'), 255, 'example 3');

use Algorithm::Combinatorics qw(permutations);

sub dictionaryrank($a) {
  my @c = split '', $a;
  my %d;
  my $ip = permutations(\@c);
  while (my $c = $ip->next) {
    $d{join('', @{$c})} = 1;
  }
  my @dd = sort keys %d;
  foreach my $i (0 .. $#dd) {
    if ($dd[$i] eq $a) {
      return $i + 1;
    }
  }
  return 0;
}
