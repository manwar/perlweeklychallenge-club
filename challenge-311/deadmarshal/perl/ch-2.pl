#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);

sub group_digit_sum{
  my ($str,$n) = @_;
  while(length $str > $n){
    my @gps = unpack("(A$n)*",$str);
    $str = join('',map{sum0 split '',$_} @gps)
  }
  $str
}

printf "%s\n",group_digit_sum('111122333',3);
printf "%s\n",group_digit_sum('1222312',2);
printf "%s\n",group_digit_sum('100012121001',4);

