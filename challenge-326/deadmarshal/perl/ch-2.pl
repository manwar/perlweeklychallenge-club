#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub decompressed_list{
  my ($arr) = @_;
  my ($i,@res) = (0);
  while($i < $#{$arr}){
    push @res, ($arr->[$i+1]) x $arr->[$i];
    $i += 2
  }
  @res
}

print show decompressed_list([1,3,2,4]);
print show decompressed_list([1,1,2,2]);
print show decompressed_list([3,1,3,2]);
  
