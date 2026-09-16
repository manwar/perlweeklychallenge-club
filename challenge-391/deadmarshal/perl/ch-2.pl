#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub arrange_box{
  my ($boxes) = @_;
  my @sorted = sort {$a->[0] <=> $b->[0] ||
		       $b->[1] <=> $a->[1]} @$boxes;
  
  my @heights = map {$_->[1]} @sorted;
  my $n = @heights;
  return 0 if $n == 0;
  
  my @dp = (1) x $n;
  my $max = 1;
  foreach my $i(0..$n-1) {
    foreach my $j(0..$i-1) {
      if($sorted[$j][0] < $sorted[$i][0] &&
	 $sorted[$j][1] < $sorted[$i][1] &&
	 $dp[$j] + 1 > $dp[$i]) {
	$dp[$i] = $dp[$j]+1;
	$max = $dp[$i] if $dp[$i] > $max
      }
    }
  }
  $max
}

is arrange_box([[1,3],[3,5],[6,8],[2,4]]),4,'Example 1';
is arrange_box([[4,5],[4,6],[6,7],[2,3],[4,3]]),3,'Example 2';
is arrange_box([[5,5],[5,5],[5,5]]),1,'Example 3';
is arrange_box([[2,100],[3,200],[4,300],[5,50],[5,400]]),
  4,'Example 4';
is arrange_box([[10,20],[15,10],[20,30],[12,18],[16,25]]),
  3,'Example 5';

done_testing();

