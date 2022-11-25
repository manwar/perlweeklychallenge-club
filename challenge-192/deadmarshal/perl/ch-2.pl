#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum);

sub equal_distribution{
  my ($arr) = @_;
  my $sum = sum(@$arr);
  if ($sum % @$arr == 0){
    my ($avg,$moves,$sum_part) = ($sum/@$arr,0,0);
    foreach my $i(0..$#$arr){
      $sum_part += $arr->[$i];
      $moves += abs($sum_part - ($avg * ($i + 1)));
    }
    return $moves;
  }
  -1;
}

print equal_distribution([1,0,5]), "\n";
print equal_distribution([0,2,0]), "\n";
print equal_distribution([0,3,0]), "\n";

