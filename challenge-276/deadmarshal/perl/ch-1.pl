#!usr/bin/env perl
use strict;
use warnings;

sub complete_day{
  my ($arr) = @_;
  my $count = 0;
  foreach my $i(0..$#$arr-1){
    foreach my $j($i+1..$#$arr){
      $count++ if(($arr->[$i] + $arr->[$j]) % 24 == 0)
    }
  }
  $count
}

printf "%d\n",complete_day([12,12,30,24,24]);
printf "%d\n",complete_day([72,48,24,55]);
printf "%d\n",complete_day([12,18,24]);
