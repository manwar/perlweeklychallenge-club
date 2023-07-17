### Task 2: Left Right Sum Diff
### Submitted by: Mohammad S Anwar
### You are given an array of integers, @ints.
### 
### Write a script to return left right sum diff array as shown below:
### 
### 
### @ints = (a, b, c, d, e)
### 
### @left  = (0, a, (a+b), (a+b+c))
### @right = ((c+d+e), (d+e), e, 0)
### @left_right_sum_diff = ( | 0 - (c+d+e) |,
###                          | a - (d+e)   |,
###                          | (a+b) - e   |,
###                          | (a+b+c) - 0 | )
### 
### Example 1:
### Input: @ints = (10, 4, 8, 3)
### Output: (15, 1, 11, 22)
### 
### @left  = (0, 10, 14, 22)
### @right = (15, 11, 3, 0)
### 
### @left_right_sum_diff = ( |0-15|, |10-11|, |14-3|, |22-0|)
###                      = (15, 1, 11, 22)
### Example 2:
### Input: @ints = (1)
### Output: (0)
### 
### @left  = (0)
### @right = (0)
### 
### @left_right_sum_diff = ( |0-0| ) = (0)
### Example 3:
### Input: @ints = (1, 2, 3, 4, 5)
### Output: (14, 11, 6, 1, 10)
### 
### @left  = (0, 1, 3, 6, 10)
### @right = (14, 12, 9, 5, 0)
### 
### @left_right_sum_diff = ( |0-14|, |1-12|, |3-9|, |6-5|, |10-0|)
###                      = (14, 11, 6, 1, 10)
#
#
#
use strict;
use warnings;

my @list = @ARGV ? @ARGV :
(10, 4, 8, 3);
# (1);
# (1, 2, 3, 4, 5);
my $n = @list;
my @left;
my @right;
my ($i, $j, $k) = (0, 0, 0);
{
	push @left, $i; 
	$i += $list[$k]; 
	unshift @right, $j;
	$k++;
	$j += $list[-$k];
	redo if @left < $n;
}
my @diff;
push(@diff, abs($left[$_] - $right[$_])) foreach 0..$k-1;
printf "Input: \@ints = (%s)\nOutput: (%s)\n", join(", ", @list), join(", ", @diff);
