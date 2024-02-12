#!/usr/bin/env perl
use strict;
use warnings;

sub merge_strings{
  my ($res,$m,$n) = ('',length $_[0],length $_[1]);
  for(my $i = 0; $i < $m || $i < $n; ++$i){
    $res .= substr $_[0],$i,1 if $i < $m;
    $res .= substr $_[1],$i,1 if $i < $n;
  }
  $res
}

printf "%s\n",merge_strings('abcd','1234');
printf "%s\n",merge_strings('abc','12345');
printf "%s\n",merge_strings('abcde','123');

