#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0 min);
use feature qw(say);

sub maximum_average{
  my ($arr,$n) = @_;
  my $max = min @$arr;
  foreach my $start(0..@$arr-$n){
    my $subsum = sum0(@{$arr}[$start..$start+$n-1]);
    my $avg = $subsum / $n;
    $max = $avg if $avg > $max
  }
  $max
}

say maximum_average([1,12,-5,-6,50,3],4);
say maximum_average([5],1);

