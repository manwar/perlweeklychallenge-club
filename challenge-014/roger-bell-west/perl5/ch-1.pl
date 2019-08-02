#! /usr/bin/perl

use strict;
use warnings;

my $s=0;
my $n=1;
print "$s ";

my @lst=(1);

my $os=0;
while (1) {
  if (defined $lst[$s]) {
    $s=$n-$lst[$s];
  } else {
    $s=0;
  }
  $lst[$os]=$n;
  $n++;
  print "$s ";
  $os=$s;
}
