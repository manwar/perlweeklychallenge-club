# And then a hero comes along

Challenge 244: https://theweeklychallenge.org/blog/perl-weekly-challenge-244/

This task was during the week of American Thanksgiving so I may not be fully present with my responses. The first task seemed straightforward enough so let's start with that one.

## Task 1: Count Smaller

```
You are given an array of integers.

Write a script to calculate the number of integers smaller than the integer at each index.

Example 1
Input: @int = (8, 1, 2, 2, 3)
Output: (4, 0, 1, 1, 3)

For index = 0, count of elements less 8 is 4.
For index = 1, count of elements less 1 is 0.
For index = 2, count of elements less 2 is 1.
For index = 3, count of elements less 2 is 1.
For index = 4, count of elements less 3 is 3.
Example 2
Input: @int = (6, 5, 4, 8)
Output: (2, 1, 0, 3)
Example 3
Input: @int = (2, 2, 2)
Output: (0, 0, 0)
```

I solve this by looping through the `@int` array and creating an array for the output for each numbers total of numbers that are smaller than it (defaulting it to 0):
```
for (my $i=0; $i < @int; $i++) {
    $int_out[$i] = 0; #default is no number is smaller than it
```

Then I loop through the `@int` array again, this time to check each number in the array (except for itself) and increment the output number when needed:
```
for (my $j=0; $j < @int; $j++) {	
    $int_out[$i]++ if ($int[$i] > $int[$j] && $i != $j);
}
```

That's it! Other than that it's just calling the sub and outputting it in the desired format.


## Task 2: Group Hero

```
You are given an array of integers representing the strength.

Write a script to return the sum of the powers of all possible combinations; power is defined as the square of the largest number in a sequence, multiplied by the smallest.


Example 1
Input: @nums = (2, 1, 4)
Output: 141

Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16

Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141
```

This task was a lot more challenging for me and I'm not entirely sure I am solving it in a sane manner, but I do appear to get the correct output.

I created a subroutine `group_hero` which accepts the input array. I then use `Algorithm::Combinatorics qw(partitions)` to create the different number combinations. Is this cheating? Maybe, but I'm okay with it. Don't worry, it's not the only "cheat" I used in this one. I also use `List::Util qw( min max )` to calculuate the min and max values in an array!

So I start byt creating the number combinations: `my @parts = partitions(\@nums);`

The final array element in `@parts` is duplicative for our purposes so I ignore that. I loop through the rest of the parts: `for (my $i=0; $i<@parts-1; $i++) {`

Each `$parts[$i]` is an array of the desired combinations so I loop through that: `foreach ( @{$parts[$i]} ) {`

Within this final loop I calculate the min, max and perform the math:
```
my $min = min @{$parts[0]};
my $max = max @{$parts[0]};
$group_hero += $max**2 * $min;
```

Then at the conclusion I return `$group_hero` with the final number.

---
The full code with comments is available at https://github.com/manwar/perlweeklychallenge-club/tree/master/challenge-244/ianrifkin
