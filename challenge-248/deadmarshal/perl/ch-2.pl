#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub submatrix_sum{
  my ($m) = @_;
  my @ret;
  foreach my $i(0..$#$m-1){
    push @ret,[];
    foreach my $j(0..$#{$m->[0]}-1){
      $ret[$i][$j] = $m->[$i][$j] + $m->[$i][$j+1] +
	$m->[$i+1][$j] + $m->[$i+1][$j+1]
    }
  }
  @ret
}

print show submatrix_sum([[1,2,3,4],[5,6,7,8],[9,10,11,12]]);
print show submatrix_sum([[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]);

