#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Algorithm::Permute;
use List::Util qw(max);

use Test::More tests => 2;

is_deeply(squareful([1, 17, 8]), [[1, 8, 17], [17, 8, 1]], 'example 1');
is_deeply(squareful([2, 2, 2]), [[2, 2, 2]], 'example 2');


sub squared($a) {
  return $a * $a;
}

sub decode($a0, $base) {
  my @eq;
  my $a = $a0;
  while ($a > 0) {
    unshift @eq, $a % $base;
    $a = int($a / $base);
  }
  return \@eq;
}

sub encode($sq, $base) {
  my $a = 0;
  foreach my $v (@{$sq}) {
    $a *= $base;
    $a += $v;
  }
  return $a;
}

sub squareful($lst) {
  my %results;
  my %squares;
  my $base = max(@{$lst}) + 1;
  my $p = Algorithm::Permute->new($lst);
  while (my @la = $p->next) {
    my $squareful = 1;
    foreach my $i (0 .. $#la - 1) {
      my $cs = $la[$i] + $la[$i + 1];
      my $mx = squared(scalar keys %squares);
      while ($cs > $mx) {
        $mx = squared((scalar keys %squares) + 1);
        $squares{$mx} = 1;
      }
      unless (exists $squares{$cs}) {
        $squareful = 0;
        last;
      }
    }
    if ($squareful) {
      $results{encode(\@la, $base)} = 1;
    }
  }
  return [map {decode($_, $base)} sort {$a <=> $b} keys %results];
}
