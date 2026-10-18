#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(wordsquares(['MA', 'AM', 'MY', 'ME']), ['MA', 'AM'], 'example 1');
is_deeply(wordsquares(['SUN', 'USE', 'NET', 'SEE', 'TEN']), ['SUN', 'USE', 'NET'], 'example 2');
is_deeply(wordsquares(['BOAT', 'TEAL', 'AREA', 'TSAR', 'OGRE']), ['BOAT', 'OGRE', 'AREA', 'TEAL'], 'example 3');
is_deeply(wordsquares(['CARD', 'AREA', 'REAR', 'DART']), ['CARD', 'AREA', 'REAR', 'DART'], 'example 4');
is_deeply(wordsquares(['HEART', 'TREND', 'EMBER', 'RESIN', 'ABUSE']), ['HEART', 'EMBER', 'ABUSE', 'RESIN', 'TREND'], 'example 5');

use Set::Scalar;

sub wordsquares($a) {
  my $l = length($a->[0]);
  my $words = Set::Scalar->new(@{$a});
  my @queue;
  foreach my $w (@{$a}) {
    push @queue, [$w];
  }
  while (scalar @queue > 0) {
    my $p = shift @queue;
    if (scalar @{$p} == $l) {
      return $p;
    }
    foreach my $ca ($words->difference(Set::Scalar->new(@{$p}))->elements) {
      my $valid = 1;
      my @cas = split '', $ca;
      while (my ($i, $c) = each @cas) {
        if ($i >= scalar @{$p}) {
          last;
        }
        if ($c ne substr($p->[$i], scalar @{$p}, 1)) {
          $valid = 0;
          last;
        }
      }
      if ($valid) {
        my @pw = @{$p};
        push @pw, $ca;
        push @queue, \@pw;
      }
    }
  }
  [];
}
