#! /usr/bin/perl

use strict;
use warnings;

my $n=11;
my $m1=length($n)+1;
my $m2=length($n*$n)+1;
my $fmt='%'.$m1.'s%1s'.(('%'.$m2.'s') x $n)."\n";
printf($fmt,'x','|',(1..$n));
printf($fmt,'-' x $m1,'+',('-' x $m2) x $n);
foreach my $row (1..$n) {
  my @a=($row,'|');
  foreach my $column (1..$n) {
    if ($column < $row) {
      push @a,'';
    } else {
      push @a,$row*$column;
    }
  }
  printf($fmt,@a);
}
