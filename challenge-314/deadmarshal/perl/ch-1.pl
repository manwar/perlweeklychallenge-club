#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0 min);

sub equal_strings{
  my @lens = map{length} @_;
  my $sum = sum0 @lens;
  my $n = min @lens;
  foreach my $i(0..$n){
    if(!(substr($_[0],$i,1) eq substr($_[1],$i,1) &&
       substr($_[1],$i,1) eq substr($_[2],$i,1))){
      return $i == 0 ? -1 : $sum - 3 * $i
    }
  }
  $sum - 3 * $n
}

printf "%d\n",equal_strings('abc','abb','ab');
printf "%d\n",equal_strings('ayz','cyz','xyz');
printf "%d\n",equal_strings('yza','yzb','yzc');

