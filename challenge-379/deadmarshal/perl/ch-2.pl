#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub is_armstrong{
  my ($base,$limit) = @_;
  grep{
    my ($v,$sum,@digits) = (0,0,split '',$_);
    $v = $v * $base + $_,$sum += $_ ** @digits for @digits;
    $v == $sum
  } 0..$limit
}

show is_armstrong(10,1000);
show is_armstrong(7,1000);
show is_armstrong(16,1000);

