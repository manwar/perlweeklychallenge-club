# Hidden loops. Or no loops at all.

**Challenge 270 solutions in Perl by Matthias Muth**

For this week's first task, I did not use any loops.<br/>
No `for`, `foreach` or `while`, or `until`.<br/>
Am I slowly turning towards functional programming?<br/>
Perl offers a lot of functions using 'lambda' expressions, aka 'code blocks', like `map`, `grep` or a lot of functions in `List::Util` or `List::MoreUtils`, and it is very natural to use them. This is perl, and There Is More Than One Way To DoIt.
Actually, iterating over the elements is still done, 'but behind the scenes', so the loops are just hidden. But in my mind, this can often make the code more readable.

For the second task I didn't use any loops at all, not even 'hidden' ones!<br/>
I am happy to have found a solution where there is no actual need of doing any of the operations described.<br/>
The overall result can be determined without.

Read on ...

## Task 1: Special Positions

> You are given a m x n binary matrix.<br/>
> Write a script to return the number of special positions in the given binary matrix.<br/>
> A position (i, j) is called special if \$matrix[i][j] == 1 and all other elements in the row i and column j are 0.<br/>
> <br/>
> Example 1<br/>
> Input: \$matrix = [ [1, 0, 0],<br/>
>                                 [0, 0, 1],<br/>
>                                 [1, 0, 0],<br/>
>                               ]<br/>
> Output: 1<br/>
> There is only special position (1, 2) as \$matrix[1][2] == 1<br/>
> and all other elements in row 1 and column 2 are 0.<br/>
> <br/>
> Example 2<br/>
> Input: \$matrix = [ [1, 0, 0],<br/>
>                                   [0, 1, 0],<br/>
>                                   [0, 0, 1],<br/>
>                                 ]<br/>
> Output: 3<br/>
> Special positions are (0,0), (1, 1) and (2,2).<br/>

As I said, there are no loops in my solution.
That is, if you don't count the iterations done internally by `map`, `grep`, `any` and `zip` as loops.

First, I extract only those rows that have exactly one non-zero element,
using a `grep` (for the non-zero elements) within a grep (for exactly one of those):

```perl
    my @single_element_rows =
        grep { ( scalar grep $_ != 0, $_->@* ) == 1 }
            $matrix->@*;
```
Next, I flip the matrix to get column vectors.
The `zip` function, applied to the rows of the matrix, results in a list of array-refs,
each one containing one column's values.
Very handy!

Then, I determine the *indexes* of all columns that have exactly one non-zero element,
same as above.
```perl
    my @columns = zip $matrix->@*;
    my @single_element_columns_indexes =
        grep { ( scalar grep $_ != 0, $columns[$_]->@* ) == 1 }
            0..$#columns;
```
Having these, I can determine and return the count of single-element rows
that happen to have a '1' in one of the single-element columns.
If we find one, we are sure it will be the only one in that row,
since we know that all rows that we look at have exactly one single non-zero element.
```perl
    return scalar grep {
        my $row = $_;
        any { $row->[$_] == 1 } @single_element_columns_indexes
    } @single_element_rows;
```
So here is the complete solution (without comments, which are still there in the original code):
```perl
use v5.36;

use List::Util qw( any zip );

sub special_positions( $matrix ) {
    my @single_element_rows =
        grep { ( scalar grep $_ != 0, $_->@* ) == 1 }
            $matrix->@*;
    my @columns = zip $matrix->@*;
    my @single_element_columns_indexes =
        grep { ( scalar grep $_ != 0, $columns[$_]->@* ) == 1 }
            0..$#columns;
    return scalar grep {
        my $row = $_;
        any { $row->[$_] == 1 } @single_element_columns_indexes
    } @single_element_rows;
}
```

## Task 2: Equalize Array

> You are give an array of integers, @ints and two integers, \$x and \$y.<br/>
> Write a script to execute one of the two options:<br/>
> Level 1:<br/>
> Pick an index i of the given array and do \$ints[i] += 1<br/>
> Level 2:<br/>
> Pick two different indices i,j and do \$ints[i] +=1 and \$ints[j] += 1.<br/>
> <br/>
> You are allowed to perform as many levels as you want to make every elements in the given array equal. There is cost attach for each level, for Level 1, the cost is \$x and \$y for Level 2.<br/>
> In the end return the minimum cost to get the work done.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (4, 1), \$x = 3 and \$y = 2<br/>
> Output: 9<br/>
> Level 1: i=1, so \$ints[1] += 1.<br/>
> @ints = (4, 2)<br/>
> Level 1: i=1, so \$ints[1] += 1.<br/>
> @ints = (4, 3)<br/>
> Level 1: i=1, so \$ints[1] += 1.<br/>
> @ints = (4, 4)<br/>
> We perforned operation Level 1, 3 times.<br/>
> So the total cost would be 3 x \$x => 3 x 3 => 9<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (2, 3, 3, 3, 5), \$x = 2 and \$y = 1<br/>
> Output: 6<br/>
> Level 2: i=0, j=1, so \$ints[0] += 1 and \$ints[1] += 1<br/>
> @ints = (3, 4, 3, 3, 5)<br/>
> Level 2: i=0, j=2, so \$ints[0] += 1 and \$ints[2] += 1<br/>
> @ints = (4, 4, 4, 3, 5)<br/>
> Level 2: i=0, j=3, so \$ints[0] += 1 and \$ints[3] += 1<br/>
> @ints = (5, 4, 4, 4, 5)<br/>
> Level 2: i=1, j=2, so \$ints[1] += 1 and \$ints[2] += 1<br/>
> @ints = (5, 5, 5, 4, 5)<br/>
> Level 1: i=3, so \$ints[3] += 1<br/>
> @ints = (5, 5, 5, 5, 5)<br/>
> We perforned operation Level 1, 1 time and Level 2, 4 times.<br/>
> So the total cost would be (1 x \$x) + (3 x \$y) => (1 x 2) + (4 x 1) => 6<br/>

Now this is a task that needs a little thinking. Nice!!

The first thing I did for developing a concept for a possible solution is that I transformed the task, actually 'flipping around' what is to be done.<br/>
I want to have an easy overview of how many operations I have to execute.
So instead of filling the numbers up to the largest value,
I create a 'to_do' array of numbers .

For example, the input array ( 1, 4, 4, 4, 6 ) would result in a 'to_do' array of ( 5, 2, 2, 2, 0 ), and the '0' can be removed, so ( 5, 2, 2, 2 ).
To visualize this:

<img src="https://github.com/MatthiasMuth/perlweeklychallenge-club/blob/muthm-270/challenge-270/matthias-muth/images/Screenshot%202024-05-26%20171318.png" />

So what used to be increments towards the highest number in the array are now decrements towards zero.
This makes computations and checking less complex.

Now it's time to make some observations:

- Doing one Level 2 two element decrements are only better than doing two Level 1 single decrement if its cost \$y is less than 2 times the Level 1 cost \$x.<br/>That means that if \$x is less than half of \$y, we can simply sum up all 'to_do' numbers , multiply it by $x, and this will be the best possible result:

  	cost = sum( to_do ) * $x1

- If we do Level 2 decrements, we need to be careful about where we do them. We might end up having a single column of elements to remove, where we will then only be able to use more costly Level 1 single removals.<br/>
  So do we risk running into a full fledged optimization problem?

Actually no, because we can distinguish two cases, which only depend on the largest number in the 'to_do' array, and determine the final result with just one formula for each of them:

1. <u>The largest number is larger than all other numbers combined.</u>

    An example:

    <img src="https://github.com/MatthiasMuth/perlweeklychallenge-club/blob/muthm-270/challenge-270/matthias-muth/images/Screenshot%202024-05-26%20174520.png" />

    The largest number here is 6, and all other numbers together sum up to 4 (shaded in light green).<br/>
    If we do Level 2 decrements that always decrement one from the largest number (shaded in light blue)
    and one from one of the other numbers (no matter which one),
    we remove all the elements shaded in light blue as well as those shaded in light green, and end up with some remaining elements in the largest number (shaded in light red). <br/>These remaining elements  have to be removed with more costly Level 1 decrements, there's no way to avoid that.

    But we can compute the total cost in this situation:

    	cost = sum( other_numbers ) * $y + ( largest_number - sum( other_numbers) ) * $x

    We do not actually need to do all the operations for knowing that!

2. <u>The largest number is not larger than all other numbers combined.</u>

   In this case, my algorithm to decrease all numbers to zero would be:

   * Repeatedly determine the largest and the second largest number<br/>and
     decrement those using a Level 2 decrement,<br/>
     until there is only one number with a value of '1' left, or no non-zero number at all. 
   * If there is one number left, use a Level 1 single decrement to reduce it to zero, too. 
   
   I could not 'scientifically prove' that this algorithm works
   for all constellation of numbers
   (under the precondition for the largest number not to exceed the sum of the rest!),
   but I did not find any constellation where it doesn't work.<br/>
   I would be very interested if anyone found a counter-example!

   But *if* the assumption is correct, again we can determine the total cost without actually doing the work!<br/>We do `int( sum( to_do ) / 2 )` Level 2 operations.<br/>
   If the sum is odd, we have to add one Level 1 operation for the last single element.   
   
   So the cost is
   
    	cost = int( sum( to_do ) / 2 ) * $y + ( sum( to_do ) % 2 ) * $x

Combining the three cases, the complete solution is much shorter than my description. Here, I left the comments in:

```perl
use v5.36;

use List::Util qw( max sum );

sub distribute_elements( $ints, $x, $y ) {
    # Flip things around, creating an array of what we need to
    # bring down to zero instead of moving everything up to the largest number.
    # 
    my $max = max( $ints->@* );
    my @to_do = grep $_ != 0, map $max - $_, $ints->@*;
    my $sum_to_do = sum( @to_do );

    # If it is more costly to decrement two numbers using level 2 decrements
    # than two times a level 1 decrement, we do everything with level 1.
    return $sum_to_do * $x
        if 2 * $x <= $y;

    # If the largest number is greater than everything else together
    # (without the largest number itself), we can do level 2 decrements
    # to decrease the largest number and any one of the other numbers
    # until there are no others anymore.
    # What is left of the largest number after that, we need to remove using
    # level 1 single decrements.
    # As we know everything in advance, we can compute the total cost even
    # without actually doing the operations.
    my $largest = max( @to_do );
    my $rest = $sum_to_do - $largest;
    return $rest * $y + ( $largest - $rest ) * $x
        if $largest > $rest;

    # Here, we know that we have enough points in the other numbers to completely
    # remove the largest one. I *ASSUME* that in this case, we *ALWAYS* can
    # repeatedly decrement the largest and second largest of the remaining
    # number, down to having nothing at all any more, or at most one single
    # leftover 1.
    # Using this assumption, we can again compute the cost without
    # really looping through the decrements.
    return int( $sum_to_do / 2 ) * $y + ( $sum_to_do % 2 ) * $x;
}
```

And loops? Not needed!

#### **Thank you for the challenge!**

