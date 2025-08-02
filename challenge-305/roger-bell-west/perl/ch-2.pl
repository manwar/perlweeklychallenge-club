#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(aliendictionary(['perl', 'python', 'raku'], ['h', 'l', 'a', 'b', 'y', 'd', 'e', 'f', 'g', 'i', 'r', 'k', 'm', 'n', 'o', 'p', 'q', 'j', 's', 't', 'u', 'v', 'w', 'x', 'c', 'z']), ['raku', 'python', 'perl'], 'example 1');
is_deeply(aliendictionary(['the', 'weekly', 'challenge'], ['c', 'o', 'r', 'l', 'd', 'a', 'b', 't', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'm', 'n', 'p', 'q', 's', 'w', 'u', 'v', 'x', 'y', 'z']), ['challenge', 'the', 'weekly'], 'example 2');

use List::Util qw(max);

sub aliendictionary($a, $dc) {
  my $mxl = max(map {length($_)} @{$a});
  my %dh;
  while (my ($i, $c) = each @{$dc}) {
    $dh{$c} = $i + 1;
  }
  my @b = @{$a};
  my %numerics;
  foreach my $w (@b) {
    my $n = 0;
    my @cc = split '', $w;
    foreach my $i (0 .. $mxl - 1) {
      $n *= 27;
      if ($i < length($w)) {
        $n += $dh{$cc[$i]};
      }
    }
    $numerics{$w} = $n;
  }
  @b = sort { $numerics{$::a} <=> $numerics{$::b} } @b;
  return \@b;
}
