#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0 max);

sub highest_row{
  max map{sum0 @$_} @{$_[0]}
}

printf "%d\n",highest_row([[4,4,4,4],
			   [10,0,0,0],
			   [2,2,2,9]]);
printf "%d\n",highest_row([[1,5],
			   [7,3],
			   [3,5]]);
printf "%d\n",highest_row([[1,2,3],
			   [3,2,1]]);
printf "%d\n",highest_row([[2,8,7],
			   [7,1,3],
			   [1,9,5]]);
printf "%d\n",highest_row([[10,20,30],
			   [5,5,5],
			   [0,100,0],
			   [25,25,25]]);

