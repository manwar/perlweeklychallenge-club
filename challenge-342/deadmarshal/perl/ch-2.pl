#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

sub max_score{
  my $res = 0;
  foreach my $i(1..(length $_[0])-1) {
    my $temp = 0;
    foreach my $j(0..$i-1) {
      $temp++ if (substr $_[0],$j,1) eq '0'
    }
    foreach my $j($i..(length $_[0])-1) {
      $temp++ if (substr $_[0],$j,1) eq '1'
    }
    $res = max $res,$temp;
  }
  $res
}

printf "%d\n",max_score('0011');
printf "%d\n",max_score('0000');
printf "%d\n",max_score('1111');
printf "%d\n",max_score('0101');
printf "%d\n",max_score('011101')
  
