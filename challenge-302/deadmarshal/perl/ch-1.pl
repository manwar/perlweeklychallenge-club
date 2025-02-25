#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(combinations);

sub ones_and_zeros{
  foreach my $s(reverse 1..@{$_[0]}){
    my $it = combinations($_[0],$s);
    while(my $comb = $it->next){
      my $joined = join '',@$comb;
      my $zeroes = $joined =~ tr/0//;
      my $ones = $joined =~ tr/1//;
      return $s if $zeroes <= $_[1] && $ones <= $_[2]
    }
  }
  0
}

printf "%d\n",ones_and_zeros(["10","0001","111001","1","0"],5,3);
printf "%d\n",ones_and_zeros(["10","1","0"],1,1);

