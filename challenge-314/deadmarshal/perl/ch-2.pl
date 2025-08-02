#!/usr/bin/env perl
use strict;
use warnings;

sub sort_column{
  my ($arr) = @_;
  my $ret = 0;
  foreach my $j(0..length($arr->[0])-1){
    foreach my $i(1..$#$arr){
      if(substr($arr->[$i],$j,1) lt substr($arr->[$i-1],$j,1)){
	$ret++;
	last
      }
    }
  }
  $ret
}

printf "%d\n",sort_column(['swpc','tyad','azbe']);
printf "%d\n",sort_column(['cba','daf','ghi']);
printf "%d\n",sort_column(['a','b','c']);

