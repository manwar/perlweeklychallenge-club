#! /usr/bin/perl

use strict;
use warnings;

use Math::BigFloat;

my $n=$ARGV[0] || 100;

my $remaining=Math::BigFloat->new(1);
my $max=0;
my $maxp=0;

foreach my $participant (1..$n) {
  my $portion=$remaining*$participant/$n;
  if ($portion > $max) {
    $max=$portion;
    $maxp=$participant;
  }
  $remaining-=$portion;
}

print "$maxp: $max\n";
