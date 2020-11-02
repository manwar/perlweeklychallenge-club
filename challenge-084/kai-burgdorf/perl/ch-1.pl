#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $N = $ARGV[0] // 1234;

if ($N >= 2147483647) {
  print "0";
}
else {
  my @numbers = split("", $N);
  while(scalar @numbers != 0) {
    print pop @numbers;
  }
}
