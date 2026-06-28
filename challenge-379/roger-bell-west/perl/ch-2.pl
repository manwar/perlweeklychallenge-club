#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(armstrongnumber(10, 1000), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407], 'example 1');
is_deeply(armstrongnumber(7, 1000), [0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250], 'example 2');
is_deeply(armstrongnumber(16, 1000), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645], 'example 3');

use List::Util qw(sum);

sub armstrongnumber($base, $limit) {
  my @out;
  foreach my $candidate (0 .. $limit - 1) {
    my @digits;
    if ($candidate == 0) {
      push @digits, 0;
    } else {
      my $c = $candidate;
      while ($c > 0) {
        push @digits, $c % $base;
        $c = int($c / $base);
      }
    }
    my $dl = scalar @digits;
    my $test = sum(map {$_ ** $dl} @digits);
    if ($test == $candidate) {
      push @out, $candidate;
    }
  }
  \@out;
}
