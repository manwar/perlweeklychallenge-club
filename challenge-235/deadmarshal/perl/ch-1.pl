#!/usr/bin/env perl
use strict;
use warnings;

sub is_ascending{
  my ($arr) = @_;
  my $cursor = 0;
  map{$cursor++ if $arr->[$_] < $arr->[$_+1]} 0..$#$arr-1;
  $cursor == $#$arr
}

sub remove_one{
  my @arr = @{$_[0]};
  my $res = 0;
  foreach my $i(0..$#arr){
    my @ret = @arr[0..$i-1,$i+1..$#arr];
    if($i == 0){@ret = @arr[1..$#arr]}
    elsif($i == $#arr){@ret = @arr[0..$#arr-1]}
    do{$res = 1; last} if is_ascending(\@ret);
  }
  $res
}

printf "%d\n",remove_one([0,2,9,4,5]);
printf "%d\n",remove_one([5,1,3,2]);
printf "%d\n",remove_one([2,2,3]);

