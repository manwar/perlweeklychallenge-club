#! /usr/bin/perl

use strict;
use warnings;

my $pi=3.1415926535;

my ($s,$c,$n)=(0,0,0);
foreach my $angle (@ARGV) {
  my $aa=$angle*$pi/180;
  $s+=sin($aa);
  $c+=cos($aa);
  $n++;
}
my $oa=atan2($s/$n,$c/$n);
print $oa*180/$pi,"\n";
