# loop-de-loop

Challenge 243: https://theweeklychallenge.org/blog/perl-weekly-challenge-243/

I decided to take what I think is a simple approcah to solving this week's problems (and I basically did the same approach in both tasks).

## Task 1: Reverse Pairs
```
You are given an array of integers.

Write a script to return the number of reverse pairs in the given array.

A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b) nums[i] > 2 * nums[j].

Example 1
Input: @nums = (1, 3, 2, 3, 1)
Output: 2

(1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
(3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1
Example 2
Input: @nums = (2, 4, 3, 5, 1)
Output: 3

(1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
(2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
(3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1
```

I added some extra code to my solutions in support of features like supporting command-line input, but let's focus on the code that actually solves the task.

I pass the `@nums` array to a subroutine `reverse_pairs` which has a nested `for` loop in it. We want to count how many times `$nums[$i]` is `>` `$nums[$j] * 2` where `$j` is any item after `$i` in the array. Since there is no point to look at an `$i` with no `$j` the parent loop should contain every array element except the last one:

```
for (my $i = 0; $i < @nums-1; $i++)
```

Within the above loop I created a nested loop to compare `$nums[$i]` to every value after it in the array. We know that `$j` is after `$i` so the loop can start at the element after `$i` and continues to the end of the array:
```
for (my $j = $i+1; $j < @nums; $j++)
```

Within that loop I increment a counter whenever `$nums[$i] > $nums[$j] * 2`

The full sub is as follows:

```
sub reverse_pairs {
    my @nums = @_;
    my $pairs_found = 0;
    for (my $i = 0; $i < @nums-1; $i++) {
	for (my $j = $i+1; $j < @nums; $j++) {
	    $pairs_found++ if ($nums[$i] > $nums[$j] * 2);
	}
    }
    return $pairs_found;
}
```


## Task 2: Floor Sum
```
You are given an array of positive integers (>=1).

Write a script to return the sum of floor(nums[i] / nums[j]) where 0 <= i,j < nums.length. The floor() function returns the integer part of the division.


Example 1
Input: @nums = (2, 5, 9)
Output: 10

floor(2 / 5) = 0
floor(2 / 9) = 0
floor(5 / 9) = 0
floor(2 / 2) = 1
floor(5 / 5) = 1
floor(9 / 9) = 1
floor(5 / 2) = 2
floor(9 / 2) = 4
floor(9 / 5) = 1
Example 2
Input: @nums = (7, 7, 7, 7, 7, 7, 7)
Output: 49
```

My solution to this task is very similar to my approach to solving task 1. Again I start with a loop of every array item, but this time the parent loop does include the last element in the array:
```
for (my $i = 0; $i < @nums; $i++)
```

Likewise, the nested loop within it needs to include every element (including where `$i == $j`) so it's basically the same loop as its parent:
```
for (my $j = 0; $j < @nums; $j++)
```

Within that loop I take the floor of `$nums[$i] / $nums[$j]` and add it to the sum of the previous values. To calculate the floor I was going to use the actual `floor()` from `POSIX` but just used `int()` -- I think it's good enough for this task but note that `int()` can sometimes produce counterintuitive results (see https://perldoc.perl.org/functions/int).

The full sub is as follows:

```
sub sum_floors {
    my @nums = @_;
    my $sum_floors = 0;
    for (my $i = 0; $i < @nums; $i++) {
	for (my $j = 0; $j < @nums; $j++) {
	    $sum_floors += int($nums[$i] / $nums[$j]);
	}
    }
    return $sum_floors;
}
```

The full code with comments is available at https://github.com/manwar/perlweeklychallenge-club/tree/master/challenge-243/ianrifkin