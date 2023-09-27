#!/usr/bin/env perl
use strict;
use warnings;

sub exact_change{
  my ($arr) = @_;
  my %hash;
  foreach(@$arr){
    if($_ == 10){
      return 0 unless $hash{5}--;
    }
    elsif($_ == 20){
      $hash{5} && $hash{10} ? do{--$hash{$_} foreach(5,10)} :
      $hash{5} > 2 ? $hash{5} -= 3 : return 0;
    }
    $hash{$_}++;
  }
  1
}

printf "%d\n",exact_change([5,5,5,10,20]);
printf "%d\n",exact_change([5,5,10,10,20]);
printf "%d\n",exact_change([5,5,5,20]);

