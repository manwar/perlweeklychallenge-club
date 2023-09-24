# Ones Removed and Zeros Duplicated

**Challenge 235 solutions in Perl by Matthias Muth**

## Task 1: Remove One

> You are given an array of integers.<br/>
> Write a script to find out if removing ONLY one integer makes it strictly increasing order.<br/>
> <br/>Example 1<br/>
> 
> Input: @ints = (0, 2, 9, 4, 6)<br/>
> Output: true<br/>
> 
> Removing ONLY 9 in the given array makes it strictly increasing order.<br/>
> <br/>
> Example 2<br/>
> 
> Input: @ints = (5, 1, 3, 2)<br/>
> Output: false<br/>
> <br/>
> Example 3<br/>
> 
> Input: @ints = (2, 2, 3)<br/>
> Output: true<br/>

For this task, I see two approaches:

#### 1. Single Pass

In this approach, we walk through the array only once.<br/>For each entry we check whether the following entry is greater.<br/>If not, we remove that violating following entry, and then we make sure with the rest of the list that this is the only violation.

For example:
  ```perl
  1-2-3-0-4-5-6
  ```
We check `1 < 2` and `2 < 3`, which both are fine. Then we check `3 < 0`, which violates the rule.
  We found a decrease, so we conclude that the `0` needs to be removed.
  We check again for the new pair (`3 < 4`), and then the rest of the list (`4 < 5`, `5 < 6`) and find them all ok.<br/>So the `0` is the only entry that needs to be removed.

And we are right in this case. But things are more complicated!

Consider the next example:
    ```perl
  1-2-3-99-4-5-6
    ```

We check `1 < 2`, `2 < 3`, `3 < 99` and they are all ok, strictly increasing. Then we find a failure checking `99 < 4`, and we conclude that the `4` needs to be removed.

But this is wrong!

In this case, it's actually the *first* of the two numbers that we just compared that has to be removed to recreate a strictly increasing order, not the second.

So we actually need to decide which of the two numbers we need to remove (we are sure that one of them has to go, if not, the violation will remain).

Once we remove one of the two numbers, the other one has to be in correct order with both entries to its left and its right. In the examples, we choose between

​    `2-3-4` and `2-0-4`

and between

​    `3-99-5` and `3-4-5`

respectively.

And actually it may be that removing neither of the two leads to a strictly increasing sequence. We then can return 'false' immediately.

In all of this, we need to verify that all the neighbors we check really exist, which bloats up the code a little.

**I did not implement this.**<br/>
It already took long enough to describe this algorithm, and the other solution I am going to propose is so nice and looks so 'perlish' to me that I really didn't consider the effort.

### 2. Just Try Them All

The second approach is <u>much</u>(!!!) easier!

We use a separate function that checks whether a given list is strictly monotonic.

We go through the array entry by entry, remove that entry from the array, and check with the function whether the resulting array is strictly monotonic. We return 'true' if we find the first entry where this is the case. 

To make it 'short'; here's my implementation:

```perl
use List::Util qw( any all );

sub is_monotonic( @a ) {
    return all { $a[$_] > $a[ $_ - 1 ] } 1..$#a;
}

sub remove_one( @ints ) {
    return
        any {
            my @try = @ints;
            splice @try, $_, 1, ();
            is_monotonic @try;
        } 0..$#ints;
}
```

## Task 2: Duplicate Zeros

> You are given an array of integers.<br/>
> Write a script to duplicate each occurrence of ZERO in the given array and shift the remaining to the right but make sure the size of array remain the same.<br/>
> <br/>Example 1<br/>
> Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)<br/>
> Ouput: (1, 0, 0, 2, 3, 0, 0, 4)<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (1, 2, 3)<br/>
> Ouput: (1, 2, 3)<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (0, 3, 0, 4, 5)<br/>
> Ouput: (0, 0, 3, 0, 0)<br/>

I use the `splice` function to insert the additional zeros after where `grep` finds any zeros in the array.

One trick is to start from the end of the array, so that the indexes of where to put in the additional zeros do not change when we add entries 'behind'.

Another trick is to just replace the rest of the array after a zero by a copy of the zero that is already there and all the following rest of the array, except its last element (to keep the total number of elements the same).<br/>
This makes it possible to use just one splice call for each zero to insert:

```perl
sub duplicate_zeros( @ints ) {
    splice @ints, $_ + 1, $#ints - $_, ( @ints[ $_ .. $#ints - 1 ] )
        for reverse grep $ints[$_] == 0, 0 .. $#ints - 1;
    return @ints;
}
```

I am quite happy with these three lines of code!

#### **Thank you for the challenge!**
