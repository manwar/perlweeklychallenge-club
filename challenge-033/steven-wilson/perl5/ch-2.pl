#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-11-05
# Week: 033

# Task #2
# Formatted Multiplication Table
# Write a script to print 11x11 multiplication table, only the top half triangle.

#   x|   1   2   3   4   5   6   7   8   9  10  11
# ---+--------------------------------------------
#   1|   1   2   3   4   5   6   7   8   9  10  11
#   2|       4   6   8  10  12  14  16  18  20  22
#   3|           9  12  15  18  21  24  27  30  33
#   4|              16  20  24  28  32  36  40  44
#   5|                  25  30  35  40  45  50  55
#   6|                      36  42  48  54  60  66
#   7|                          49  56  63  70  77
#   8|                              64  72  80  88
#   9|                                  81  90  99
#  10|                                     100 110
#  11|                                         121


use strict;
use warnings;

printf("  x| %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d %3d\n", 1..11);
printf("---+--------------------------------------------\n");

for (1..11) {
  my @row = get_row($_);
  print sprintf("%3d|", $_);
  map { $_ == 0 ? print "    " : printf(" %3d", $_)} @row;
  print "\n";
}

sub get_row {
  my $row = shift;
  my @row = map {$_ < $row ? 0 : $_ * $row } 1..11;
}
