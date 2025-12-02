#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(shufflepairs(1, 1000, 1), 0, 'example 1');
is(shufflepairs(1500, 2500, 1), 3, 'example 2');
is(shufflepairs(1000000, 1500000, 5), 2, 'example 3');
is(shufflepairs(13427000, 14100000, 2), 11, 'example 4');
is(shufflepairs(1000, 5000, 1), 7, 'example 5');

sub counterify($a) {
  my %m;
  foreach my $i (@{$a}) {
    $m{$i}++;
  }
  return \%m;
}

sub countdigits($a) {
  counterify([split '', $a]);
}

sub comparehash($a, $b) {
  unless (scalar %{$a} == scalar %{$b}) {
    return 0;
  }
  my %h;
  foreach my $k (keys %{$a}) {
    $h{$k} = 1;
  }
  foreach my $k (keys %{$b}) {
    $h{$k} = 1;
  }
  foreach my $k (keys %h) {
    unless (exists $a->{$k} && exists $b->{$k} && $a->{$k} == $b->{$k}) {
      return 0;
    }
  }
  1;
}

sub shufflepairs($low, $high, $pairs) {
  my $total = 0;
  foreach my $candidate ($low .. $high) {
    my $candidatec = countdigits($candidate);
    my $cnt = 0;
    foreach my $mul (2 .. 9) {
      my $test = $candidate * $mul;
      my $testc = countdigits($test);
      if (comparehash($testc, $candidatec)) {
        $cnt++;
        if ($cnt >= $pairs) {
          last;
        }
      }
    } 
    if ($cnt >= $pairs) {
      $total++;
    }
  }
  $total;
}
