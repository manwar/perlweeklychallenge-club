#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub peak_positions{
  my ($arr) = @_;
  my @res;
  foreach my $i(1..$#$arr) {
    if($arr->[$i-1] < $arr->[$i] && $arr->[$i+1] < $arr->[$i]) {
      push @res,$i
    }
  }
  @res
}

show peak_positions([1,3,2]);
show peak_positions([2,4,6,5,3]);
show peak_positions([1,2,3,2,4,1]);
show peak_positions([5,3,1]);
show peak_positions([1,5,1,5,1,5,1]);

