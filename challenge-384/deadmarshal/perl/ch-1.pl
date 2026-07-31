#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub base_n{
  my ($num,$base) = @_;
  my @chars = ('0'..'9','A'..'Z','a'..'z','+','/');
  my @digits;
  if($num == 0){
    @digits = (0);
  } else {
    while($num > 0){
      unshift @digits,$num % $base;
      $num = int($num / $base)
    }
  }
  join '',map{$chars[$_]} @digits
}

is base_n(42,2),'101010','Example 1';
is base_n(15642094,16),'EEADEE','Example 2';
is base_n(493,8),'755','Example 3';
is base_n(2228519,36),'1BRJB','Example 4';
is base_n(123456789,64),'7MyqL','Example 5';

done_testing();

