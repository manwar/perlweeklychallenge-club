#!/usr/bin/perl

# Peter Campbell Smith - 2022-02-17
# PWC 152 task 1

use v5.28;
use strict;
use utf8;

# You are given a triangle array.
# Write a script to find the minimum sum path from top to bottom.

my ($test, $answer, @row, $r, @examples, $ex);

$examples[0] = qq[
    [1], 
   [5,3], 
  [2,3,4], 
 [7,1,0,2], 
[6,4,5,2,8] ];   # answer is 8
			
$examples[1] = qq[
    [5],
   [2,3],
  [4,1,5],
 [0,1,2,3],
[7,2,4,1,9] ];   # answer is 9

$examples[2] = qq[
            [ 9],
           [ 7, 8],
         [11,22,33],
        [ 2, 3, 4, 5],
      [ 9, 8, 7, 6, 5],
     [23,34,45,56,67,78],
   [17, 0,66, 3, 6,42, 1],
  [ 3, 6,33,11,-5, 6,12, 4],
[12, 3, 4, 7, 0, 3,-1, 2,99] ];   # answer is 51
						 
# loop over examples
for $ex (0..$#examples) {
	
	# evaluate example string as array ref of array refs
	say qq[\nInput:$examples[$ex]];
	$test = eval("[$examples[$ex]]");
	
	# add the least members of each row
	$answer = 0;
	for $r (0..$#{$test}) {
		@row = @{$test->[$r]};
		$answer += smallest(@row);
	}
	
	say qq[\nOutput: $answer];
}

sub smallest {
	
	my ($answer);
	
	# returns the least member of the input array
	$answer = 999;
	$answer = $_ < $answer ? $_ : $answer for (@_);
	return $answer;
}
			