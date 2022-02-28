#!/usr/bin/env perl
use strict;
use warnings;

sub factorial{
  my $n = shift;
  if($n == 0){return 1;}
  else{return $n * factorial($n-1);}
}

sub left_factorial{
  my $n = shift;
  my $sum = 0;
  for(my $i = 0; $i < $n; $i++){
    $sum += factorial($i);
  }
  return $sum;
}

foreach(1..10){
  print left_factorial($_), " ";
}
