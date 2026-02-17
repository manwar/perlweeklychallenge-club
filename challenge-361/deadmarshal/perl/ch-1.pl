#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub zeckendorf_representation{
  my ($n) = @_;
  my @fibs = (1,2);
  push @fibs,$fibs[-1] + $fibs[-2] while($fibs[-1] + $fibs[-2] <= $n);
  
  my ($i,$rem,@parts) = ($#fibs,$n);
  while($rem) {
    if($fibs[$i] <= $rem) {
      push @parts,$fibs[$i];
      $rem -= $fibs[$i];
      $i -= 2;
    } else {
      --$i
    }
  }
  @parts
}

show zeckendorf_representation(4);
show zeckendorf_representation(12);
show zeckendorf_representation(20);
show zeckendorf_representation(96);
show zeckendorf_representation(100);

