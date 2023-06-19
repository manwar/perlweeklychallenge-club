#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

sub is_arithmetic
{
  my ($arr) = @_;
  return 0 if(@$arr < 2);
  map{
    return 0 if($arr->[$_+1] - $arr->[$_] != $arr->[1] - $arr->[0])
  } 1..$#$arr-1;
  1
}

sub arithmetic_sequence
{
  my ($arr) = @_;
  my @res;
  if(is_arithmetic($arr))
  {
    return scalar @$arr
  }
  else
  {
    map{
      push @res, arithmetic_sequence([$arr->@[0..$_-1,$_+1..$#$arr]]);
    }0..$#$arr;
  }
  max @res;
}

printf "%d\n", arithmetic_sequence([9,4,7,2,10]);
printf "%d\n", arithmetic_sequence([3,6,9,12]);
printf "%d\n", arithmetic_sequence([20,1,15,3,10,5,8]);

