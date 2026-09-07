#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(uncommonwords('apple banana apple', 'banana orange'), ['orange'], 'example 1');
is_deeply(uncommonwords('cat dog', 'bird fish'), ['cat', 'dog', 'bird', 'fish'], 'example 2');
is_deeply(uncommonwords('the quick brown fox', 'the quick'), ['brown', 'fox'], 'example 3');
is_deeply(uncommonwords('hello', 'hello'), [], 'example 4');
is_deeply(uncommonwords('blue blue red', 'red green green yellow'), ['yellow'], 'example 5');

sub uncommonwords($a, $b) {
  my %c;
  foreach my $s ($a, $b) {
    foreach my $w (split ' ', $s) {
      $c{$w}++;
    }
  }
  my @out;
  foreach my $s ($a, $b) {
    foreach my $w (split ' ', $s) {
      if ($c{$w} == 1) {
        push @out, $w;
      }
    }
  }
  \@out;
}
