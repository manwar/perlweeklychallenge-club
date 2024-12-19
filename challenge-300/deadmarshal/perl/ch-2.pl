#!/usr/bin/env perl
use strict;
use warnings;

sub nested_array{
  my ($arr) = @_;
  my $max = 0;
  foreach my $i(0..$#$arr){
    my $len = 0;
    my $set = $arr->[$i];
    my %used;
    while(!exists $used{$set}){
      undef $used{$set};
      $set = $arr->[$set];
      ++$len
    }
    $max = $len if $len > $max
  }
  $max
}

printf "%d\n",nested_array([5,4,0,3,1,6,2]);
printf "%d\n",nested_array([0,1,2]);

