#!/usr/bin/env perl

use 5.030;
use warnings;
use strict;

my @results = [ undef, 1..11 ];
for my $i (1..11) {
  push @results, [ $i, map { $_ >= $i ? $_ * $i : undef } 1..11 ]
}

say for map { join ' ', map { sprintf '%3s', $_ // '' } @$_ } @results;

__DATA__
Output:

      1   2   3   4   5   6   7   8   9  10  11
  1   1   2   3   4   5   6   7   8   9  10  11
  2       4   6   8  10  12  14  16  18  20  22
  3           9  12  15  18  21  24  27  30  33
  4              16  20  24  28  32  36  40  44
  5                  25  30  35  40  45  50  55
  6                      36  42  48  54  60  66
  7                          49  56  63  70  77
  8                              64  72  80  88
  9                                  81  90  99
 10                                     100 110
 11                                         121

