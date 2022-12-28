#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub wiggle_sort{
  my ($A) = @_;
  for(my $i = 0; $i < @$A-2; ++$i){
    if(($i % 2 == 0) == ($A->[$i] > $A->[$i+1])){
      ($A->[$i],$A->[$i+1]) = ($A->[$i+1],$A->[$i]);
    }
  }
  sprintf "(%s)\n" => join ',' => @$A;
}

print wiggle_sort([1,5,1,1,6,4]);
print wiggle_sort([1,3,2,2,3,1]);

