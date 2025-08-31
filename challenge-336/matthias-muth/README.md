# Equal Groups and Final Scores

**Challenge 336 solutions in Perl by Matthias Muth**

## Task 1: Equal Group

> You are given an array of integers.<br/>
> Write a script to return true if the given array can be divided into one or more groups: each group must be of the same size as the others, with at least two members, and with all members having the same value.
>
> **Example 1**
>
> ```text
> Input: @ints = (1,1,2,2,2,2)
> Output: true
>
> Groups: (1,1), (2,2), (2,2)
>```
> 
>**Example 2**
> 
>```text
> Input: @ints = (1,1,1,2,2,2,3,3)
> Output: false
> 
>Groups: (1,1,1), (2,2,2), (3,3)
> ```
>
> **Example 3**
>
> ```text
>Input: @ints = (5,5,5,5,5,5,7,7,7,7,7,7)
> Output: true
> 
> Groups: (5,5,5,5,5,5), (7,7,7,7,7,7)
>```
> 
>**Example 4**
> 
>```text
> Input: @ints = (1,2,3,4)
>Output: false
> ```
> 
> **Example 5**
>
> ```text
>Input: @ints = (8,8,9,9,10,10,11,11)
> Output: true
>
> Groups: (8,8), (9,9), (10,10), (11,11)
> ```

##### Approach

I first determine how often each number occurs, in other words, the **frequency** of each number.

If we need to split all numbers into groups of the same size, the frequencies of all numbers must be divisible by that group size. I determine the **divisors** of each number's frequency to get a list of possible group sizes for each number.

Now, we are looking for a possible group size for *all* numbers. For this to happen, that group size must be in the list of divisors of *all* number's frequencies.

We can make this easy and just count how often each divisor occurs, and if that count matches the count of distinct input numbers, we have found a possible group size.

##### Implementation

For this task, I base my solution on some common modules.

The `frequency` function from `List::MoreUtils` is a good and solid way for determining the frequencies of the input numbers:

```perl
    use List::MoreUtils qw( frequency );
    my %counts = frequency( @ints );
```

For finding all possible divisors for each of the frequencies, `Math::Prime::Util` offers the `divisors` function, which is a perfect fit. I only need to exclude `1` (which always is a divisor) from being a possible group size. I put all possible divisors of all numbers into one big array, because we actually don't need the individual divisors per number, but we only need their count in the next step.

```perl
    use Math::Prime::Util qw( divisors );
    my @all_divisors = grep $_ != 1, map divisors( $_ ), values %counts;
```

We can use `frequency` again to determine how often each divisor exists:

```perl
    my %divisor_frequencies = frequency @all_divisors;
```

Eventually, `any` (from `List::Util`) can check whether there is any divisor whose frequency matches the count of all distinct input numbers. We already have the 'distinct input numbers': as we created a hash with the numbers' frequency counts, the keys in that hash are the distinct numbers. So we can use a shortcut and save some CPU cycles by using `scalar keys %counts` instead of `scalar uniq @ints` to get the number of distinct input numbers:

```perl
    return any { $_ == scalar keys %counts } values %divisor_frequencies;
```

This strategy, making good use of existing modules (whether in core Perl or on CPAN), results in a four lines-of-code solution:

```perl
use v5.36;
use List::MoreUtils qw( frequency );
use Math::Prime::Util qw( divisors );
use List::Util qw( any );

sub equal_group( @ints ) {
    my %counts = frequency( @ints );
    my @all_divisors = grep $_ != 1, map divisors( $_ ), values %counts;
    my %divisor_frequencies = frequency @all_divisors;
    return any { $_ == scalar %counts } values %divisor_frequencies;
}
```

## Task 2: Final Score

> You are given an array of scores by a team.<br/>
> Write a script to find the total score of the given team. The score can be any integer, +, C or D. The + adds the sum of previous two scores. The score C invalidates the previous score. The score D will double the previous score.
>
> **Example 1**
>
> ```text
> Input: @scores = ("5","2","C","D","+")
> Output: 30
>
> Round 1: 5
> Round 2: 5 + 2
> Round 3: 5 (invalidate the previous score 2)
> Round 4: 5 + 10 (double the previous score 5)
> Round 5: 5 + 10 + 15 (sum of previous two scores)
>
> Total Scores: 30
>```
> 
>**Example 2**
> 
>```text
> Input: @scores = ("5","-2","4","C","D","9","+","+")
> Output: 27
> 
>Round 1: 5
> Round 2: 5 + (-2)
> Round 3: 5 + (-2) + 4
> Round 4: 5 + (-2) (invalidate the previous score 4)
> Round 5: 5 + (-2) + (-4) (double the previous score -2)
> Round 6: 5 + (-2) + (-4) + 9
> Round 7: 5 + (-2) + (-4) + 9 + 5 (sum of previous two scores)
> Round 8: 5 + (-2) + (-4) + 9 + 5 + 14 (sum of previous two scores)
> 
>Total Scores: 27
> ```
>
> **Example 3**
>
> ```text
>Input: @scores = ("7","D","D","C","+","3")
> Output: 45
> 
> Round 1: 7
>Round 2: 7 + 14 (double the previous score 7)
> Round 3: 7 + 14 + 28 (double the previous score 14)
> Round 4: 7 + 14 (invalidate the previous score 28)
> Round 5: 7 + 14 + 21 (sum of previous two scores)
> Round 6: 7 + 14 + 21 + 3
> 
> Total Scores: 45
>```
> 
>**Example 4**
> 
>```text
> Input: @scores = ("-5","-10","+","D","C","+")
>Output: -55
> 
> Round 1: (-5)
> Round 2: (-5) + (-10)
>Round 3: (-5) + (-10) + (-15) (sum of previous two scores)
> Round 4: (-5) + (-10) + (-15) + (-30) (double the previous score -15)
> Round 5: (-5) + (-10) + (-15) (invalidate the previous score -30)
> Round 6: (-5) + (-10) + (-15) + (-25) (sum of previous two scores)
> 
> Total Scores: -55
> ```
>
> **Example 5**
>
> ```text
>Input: @scores = ("3","6","+","D","C","8","+","D","-2","C","+")
> Output: 128
>
> Round  1: 3
> Round  2: 3 + 6
> Round  3: 3 + 6 + 9 (sum of previous two scores)
>Round  4: 3 + 6 + 9 + 18 (double the previous score 9)
> Round  5: 3 + 6 + 9 (invalidate the previous score 18)
> Round  6: 3 + 6 + 9 + 8
> Round  7: 3 + 6 + 9 + 8 + 17 (sum of previous two scores)
> Round  8: 3 + 6 + 9 + 8 + 17 + 34 (double the previous score 17)
> Round  9: 3 + 6 + 9 + 8 + 17 + 34 + (-2)
> Round 10: 3 + 6 + 9 + 8 + 17 + 34 (invalidate the previous score -2)
> Round 11: 3 + 6 + 9 + 8 + 17 + 34 + 51 (sum of previous two scores)
> 
> Total Scores: 128
> ```

We obviously need a loop. Let's see how I can write that in a somewhat elegant style that is easy to follow.

Apparently we need an array for keeping the list of scores. We only operate on the most recent entries, so it actually implements a stack, but I call it `@list` nevertheless because it is used for building the final list of scores. So:

```perl
    my @list;
```

Then we loop over the 'input scores'. The word 'score' is a bit ambiguous, because it can mean the 'input scores', which includes commands like `'C'`, `'D'`, or `'+'`, but it also means the final list of scores, which only consist of numbers that we will eventually sum up.

What we get as 'input scores' may be integer numbers (including negative ones), or commands. To distinguish between them, and to do what is needed for each of them, my preferred structure is this one:

```perl
    for ( @scores ) {
        /^C$/   and do { ... };
        /^D$/   and do { ... };
        /^\+$/  and do { ... };
        /-?\d+$ and do { ... };
    }
```

This nicely groups the possible inputs, and gives a good overview over the whole process.

Now we have to fill in what to do for each case:

* `'C'`:
  `pop` the last value from the `@list` stack.
* `'D'`: double the last value and `push` the result on the stack.
* `'+'`: add the last two entries and `push` the sum on the stack.
* A (possibly negative) integer number: simply `push` it on the stack.

Everything else is silently ignored.

In the end I use `sum` from `List::Util` to sum up the scores gathered in the `@list` array. 

This is my solution for task 2:

```perl
use v5.36;
use List::Util qw( sum );

sub final_score( @scores ) {
    my @list;
    for ( @scores ) {
        /^C$/    and do { pop @list;                         next };
        /^D$/    and do { push @list, 2 * $list[-1];         next };
        /^\+$/   and do { push @list, $list[-2] + $list[-1]; next };
        /-?\d+$/ and do { push @list, $&;                    next };
    }
    return sum( @list );
}
```

I hope it's easy enough to recognize the task structure in the code.

#### **Thank you for the challenge!**
