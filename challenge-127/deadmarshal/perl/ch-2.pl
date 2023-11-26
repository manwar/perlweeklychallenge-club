#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub conflict_intervals{
  my ($arr) = @_;
  my @ret;
  foreach my $i(1..$#$arr){
    my $b = 0;
    foreach my $j(0..$i-1){
      $b = 1 if $arr->[$i][0] >= $arr->[$j][0] &&
	$arr->[$i][0] <= $arr->[$j][1];
    }
    push @ret, $arr->[$i] if $b;
  }
  @ret
}

print show conflict_intervals([[1,4],[3,5],[6,8],[12,13],[3,20]]);
print show conflict_intervals([[3,4],[5,7],[6,9],[10,12],[13,15]]);

