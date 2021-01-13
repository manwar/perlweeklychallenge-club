#! /usr/bin/perl

use strict;
use warnings;

my @i;

while (@ARGV) {
  if (scalar @ARGV > 1) {
    push @i,[sort (shift @ARGV,shift @ARGV)];
  }
}

my $dirty=1;
while ($dirty) {
  $dirty=0;
OUTER:
  foreach my $a (0..$#i-1) {
    foreach my $b ($a+1..$#i) {
      if ($i[$a][1] >= $i[$b][0]) {
        $i[$a][1]=$i[$b][1];
        splice @i,$b,1;
        $dirty=1;
        last OUTER;
      }
    }
  }
}

my @o;
foreach my $range (@i) {
  push @o,'['.$range->[0].', '.$range->[1].']';
}
print join(', ',@o),"\n";
