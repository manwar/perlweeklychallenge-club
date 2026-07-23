#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(replacequestionmark('01??0'), ['01000', '01010', '01100', '01110'], 'example 1');
is_deeply(replacequestionmark('101'), ['101'], 'example 2');
is_deeply(replacequestionmark('???'), ['000', '001', '010', '011', '100', '101', '110', '111'], 'example 3');
is_deeply(replacequestionmark('1?10'), ['1010', '1110'], 'example 4');
is_deeply(replacequestionmark('1?1?0'), ['10100', '10110', '11100', '11110'], 'example 5');

sub replacequestionmark($a) {
  my @template = split '', $a;
  my $q = scalar grep {$_ eq '?'} @template;
  if ($q == 0) {
    return [$a];
  }
  my @out;
  foreach my $n (0 .. (1 << $q) - 1) {
    my @qm;
    my $nn = $n;
    while ($nn > 0) {
      if ($nn % 2 == 1) {
        push @qm, '1';
      } else {
        push @qm, '0';
      }
      $nn = int($nn / 2);
    }
    while (scalar @qm < $q) {
      push @qm, '0';
    }
    my $entry = "";
    foreach my $tc (@template) {
      if ($tc eq '?') {
        $entry .= pop @qm;
      } else {
        $entry .= $tc;
      }
    }
    push @out, $entry;
  }
  \@out;
}
