#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub duplicate_zeros{
  my ($arr) = @_;
  my ($i,@stk) = (0);
  while($i < @$arr && @stk != @$arr){
    if($arr->[$i] == 0 && (@stk+1 < @$arr)) {
      push @stk,0 for 0..1;
      $i++
    } else {
      push @stk,$arr->[$i++]
    }
  }
  @stk
}

print show duplicate_zeros([1,0,2,3,0,4,5,0]);
print show duplicate_zeros([1,2,3]);
print show duplicate_zeros([1,2,3,0]);
print show duplicate_zeros([0,0,1,2]);
print show duplicate_zeros([1,2,0,3,4]);

