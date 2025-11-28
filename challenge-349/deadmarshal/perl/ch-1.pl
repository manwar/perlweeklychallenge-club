#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

sub power_string{
  my ($res,$temp) = (1,1);
  my @chars = split '',$_[0];
  foreach my $i(1..$#chars){
    if($chars[$i] eq $chars[$i-1]) {$res = max($res,++$temp)}
    else {$temp = 1}
  }
  $res
}

printf "%d\n",power_string("textbook");
printf "%d\n",power_string("aaaaa");
printf "%d\n",power_string("hoorayyy");
printf "%d\n",power_string("x");
printf "%d\n",power_string("aabcccddeeffffghijjk")
  
