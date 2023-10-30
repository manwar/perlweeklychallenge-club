#!/usr/bin/env perl
use strict;
use warnings;

sub duplicate_zeros{
  my ($arr) = @_;
  my @ret;
  foreach(@$arr){
    last if @ret == @$arr;
    $_ == 0 ? splice @ret,@ret,0,(0,0) : push @ret,$_;
  }
  @ret
}

printf "(%s)\n", join ',',duplicate_zeros([1,0,2,3,0,4,5,0]);
printf "(%s)\n", join ',',duplicate_zeros([1,2,3]);
printf "(%s)\n", join ',',duplicate_zeros([0,3,0,4,5]);

