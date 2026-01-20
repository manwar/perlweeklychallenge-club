#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(uniquefractiongenerator(3), ['1/3', '1/2', '2/3', '1/1', '3/2', '2/1', '3/1'], 'example 1');
is_deeply(uniquefractiongenerator(4), ['1/4', '1/3', '1/2', '2/3', '3/4', '1/1', '4/3', '3/2', '2/1', '3/1', '4/1'], 'example 2');
is_deeply(uniquefractiongenerator(1), ['1/1'], 'example 3');
is_deeply(uniquefractiongenerator(6), ['1/6', '1/5', '1/4', '1/3', '2/5', '1/2', '3/5', '2/3', '3/4', '4/5', '5/6', '1/1', '6/5', '5/4', '4/3', '3/2', '5/3', '2/1', '5/2', '3/1', '4/1', '5/1', '6/1'], 'example 4');
is_deeply(uniquefractiongenerator(5), ['1/5', '1/4', '1/3', '2/5', '1/2', '3/5', '2/3', '3/4', '4/5', '1/1', '5/4', '4/3', '3/2', '5/3', '2/1', '5/2', '3/1', '4/1', '5/1'], 'example 5');

sub gcd($m,$n) {
  while ($n!=0) {
    ($m,$n)=($n,$m % $n);
  }
  return $m;
}

sub uniquefractiongenerator($a) {
  my $den = 1;
  foreach my $dn (2 .. $a) {
    $den *= $dn;
  }
  my %f;
  foreach my $d (1 .. $a) {
    my $nd = int($den / $d);
    foreach my $n (1 .. $a) {
      $f{$n * $nd} = 1;
    }
  }
  my @out;
  foreach my $n (sort {$::a <=> $::b} keys %f) {
    my $g = gcd($n, $den);
    my $nn = int($n/$g);
    my $nd = int($den/$g);
    push @out, "$nn/$nd";
  }
  \@out;
}
