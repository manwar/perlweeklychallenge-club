#! /usr/bin/perl

use strict;
use warnings;

use Math::BigFloat try => 'GMP';

my $a=0;
my $b=Math::BigFloat->new(1);
my $e=Math::BigFloat->new(1);

while (1) {
  $a++;
  $b/=$a;
  $e+=$b;
  print "$e\n";
}
