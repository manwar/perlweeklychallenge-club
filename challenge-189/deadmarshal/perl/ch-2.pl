#!/usr/bin/env perl
use strict;
use warnings;

sub array_degree{
  my ($arr) = @_;
  my (%left,%count);
  my ($max,$min,$index) = (0) x 3;
  for(my $i = 0; $i < @$arr; ++$i){
    my $x = $arr->[$i];
    if(!$count{$x}){
      $left{$x} = $i;
      $count{$x} = 1;
    }
    else{
      $count{$x}++;
    }
    if($count{$x} > $max){
      $max = $count{$x};
      $min = $i - $left{$x} + 1;
      $index = $left{$x};
    }
    elsif(($count{$x} == $max) &&
	  ($i - $left{$x} + 1 < $min)){
      $min = $i - $left{$x} + 1;
      $index = $left{$x};
    }
  }
  foreach($index..$index+$min-1){
    print $arr->[$_], ' ';
  }
  print "\n";
}

array_degree([1,3,3,2]);
array_degree([1,2,1,3]);
array_degree([1,3,2,1,2]);
array_degree([1,1,2,3,2]);
array_degree([2,1,2,1,1]);

