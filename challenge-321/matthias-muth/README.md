# Elegance Makes the Maximum Difference
**Challenge 320 solutions in Perl by Matthias Muth**

## Task 1: Maximum Count

> You are given an array of integers.<br/>
> Write a script to return the maximum between the number of positive and negative integers. Zero is neither positive nor negative.
>
> **Example 1**
>
> ```text
> Input: @ints = (-3, -2, -1, 1, 2, 3)
> Output: 3
>
> There are 3 positive integers.
> There are 3 negative integers.
> The maximum between 3 and 3 is 3.
>```
> 
>**Example 2**
> 
>```text
> Input: @ints = (-2, -1, 0, 0, 1)
> Output: 2
> 
>There are 1 positive integers.
> There are 2 negative integers.
> The maximum between 2 and 1 is 2.
> ```
>
> **Example 3**
>
> ```text
>Input: @ints = (1, 2, 3, 4)
> Output: 4
> 
> There are 4 positive integers.
>There are 0 negative integers.
> The maximum between 4 and 0 is 4.
> ```

It's a matter of taste:

* <u>Single pass</u>:<br/>
  Go through the list of integers in a loop,
  increment one of two counters depending on the number's sign.
  Then return the maximum of the two counts.

* <u>Two-pass</u>:<br/>
  Count the negative and positive numbers separately,
  then return the maximum.

Clearly, from an algorithm point of view, and regarding performance,
the single pass alternative is to be preferred.
No waste of resources going through the data twice
only to ignore half of the data in each pass.
So let's write it out:

```perl
#  Single pass solution.
sub maximum_count( @ints ) {
    my ( $count_pos, $count_neg ) = ( 0, 0 );
    for ( @ints ) {
        if ( $_ > 0 ) {
            ++$count_pos
        }
        elsif ( $_ < 0 ) {
            ++$count_neg
        }
    }
    return $count_pos > $count_neg ? $count_pos : $count_neg;
}
```

But even if this probably is high-performance, it has a problem:<br/>
I don't really like it.<br/>
Too much programming!

For a two-pass solution, with a little bit of Perl magic and a functional touch,
we can avoid the `for` loop,
and we can avoid using variables at all.

For me, this is a much clearer and nicer solution:

```perl
use v5.36;

use List::Util qw( max );

# Two-pass, preferred solution.
sub maximum_count( @ints ) {
    return max( scalar grep( $_ > 0, @ints ), scalar grep( $_ < 0, @ints ) );
}
```

I will reconsider only once I really need that one little bit of higher performance.<br/>
Until then, I am very happy with less programming and less typos!

## Task 2: Sum Difference

> You are given an array of positive integers.<br/>
> Write a script to return the absolute difference between digit sum and element sum of the given array.
>
> **Example 1**
>
> ```text
> Input: @ints = (1, 23, 4, 5)
> Output: 18
>
> Element sum: 1 + 23 + 4 + 5 => 33
> Digit sum: 1 + 2 + 3 + 4 + 5 => 15
> Absolute difference: | 33 - 15 | => 18
>```
> 
>**Example 2**
> 
>```text
> Input: @ints = (1, 2, 3, 4, 5)
> Output: 0
> 
>Element sum: 1 + 2 + 3 + 4 + 5 => 15
> Digit sum: 1 + 2 + 3 + 4 + 5 => 15
> Absolute difference: | 15 - 15 | => 0
> ```
>
> **Example 3**
>
> ```text
>Input: @ints = (1, 2, 34)
> Output: 27
> 
> Element sum: 1 + 2 + 34 => 37
>Digit sum: 1 + 2 + 3 + 4 => 10
> Absolute difference: | 37 - 10 | => 27
> ```

We need to compare two sums:

* the sum of the integers in `@ints`,
* the digit sum of the integers in `@ints`.

The first part is very simple. Using `sum` from `List::Util`:

```perl
    sum( @ints )
```

For the second part, the digit sum, we have several options:

* Map each integer in `@ints` into its <u>individual digit sum</u>,
  then sum up those digit sums:

  ```perl
      sum( map sum( split "", $_ ), @ints )
  ```

* Map each integer in `@ints` into the <u>list of its digits</u>,
  then sum up all the digits in one go:

  ```perl
      sum( map split( "", $_ ), @ints )
  ```

  This avoids the repeated calls to `sum` for the individual digit sums. 

* Concatenate all the integers in `@ints` into <u>one string</u>,
  then split it up into single digits,
  and sum them up:

  ```perl
      sum( split "", join "", @ints )
  ```

So here we are again:
There's more than one way to do it...<br/>
And choosing my favorite is not easy here.

I would probably not use the first one.<br/>
It simply isn't necessary to have every individual element's digit sum.
We can easily avoid all those function calls.

The second one for me is the 'correct' one. <br/>
Nothing done that is not necessary, very efficient.

But my heart beats for the third solution.

Even if it needs that additional step of generating an intermediate string,
I like how concise and simple it is.
And apart from the additional memory needed for that string
I'm not even sure whether it's not just as efficient as the 'correct' second solution.<br/>
Only a benchmark could tell.

So here we go.<br/>
If in doubt, I choose elegance! 

```perl
use v5.36;

use List::Util qw( sum );

sub sum_difference( @ints ) {
    return abs( sum( split "", join "", @ints ) - sum( @ints ) ); 
}
```

**Addendum:**

I couldn't refrain myself from running that benchmark:

```text
                     Rate sum_difference_1 sum_difference_2 sum_difference_3
sum_difference_1 136455/s               --             -12%             -24%
sum_difference_2 155121/s              14%               --             -14%
sum_difference_3 180004/s              32%              16%               --
```

My preferred one-string solution is the fastest!<br/>
What can I say?


#### **Thank you for the challenge!**
