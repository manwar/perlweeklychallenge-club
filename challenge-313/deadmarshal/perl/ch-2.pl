#!/usr/bin/env perl
use strict;
use warnings;

sub reverse_letters{
  my @chars = split '',$_[0];
  my ($i,$j) = (0,$#chars);
  while($i < $j){
    $i++ while($i < $j and $chars[$i] !~ /[[:alpha:]]/);
    $j-- while($i < $j and $chars[$j] !~ /[[:alpha:]]/);
    ($chars[$i++],$chars[$j--]) = ($chars[$j],$chars[$i]) if $i < $j;
  }
  join '',@chars
}

printf "%s\n",reverse_letters('p-er?l');
printf "%s\n",reverse_letters('wee-k!L-y');
printf "%s\n",reverse_letters('_c-!h_all-en!g_e');

