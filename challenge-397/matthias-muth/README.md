# Reflections on Missing Numbers
**Challenge 397 solutions in Perl by Matthias Muth**

## Task 1: Absent Smallest Positive

> You are given an array of integers.<br/>
> Write a script to return the smallest absent positive integer such that it is strictly greater than the average of all elements in the given array.
>
> **Example 1**
>
> ```text
> Input: @arr = (1, 2, 4, 5, 6)
> Output: 7
>
> Average: (1 + 2 + 4 + 5 + 6) / 5 = 3.6
> We need the smallest positive integer absent from nums that is strictly greater than 3.6.
> The positive integers greater than 3.6 are 4, 5, 6, 7, ....
>
> 4 is in the given array.
> 5 is in the given array.
> 6 is in the given array.
> 7 is not in.
> ```
>
> **Example 2**
>
> ```text
> Input: @arr = (-5, -2, -1, 3)
> Output: 1
>
> Average: (-5 -2 -1 + 3) / 4 = -1.25
> We need the smallest absent positive integer strictly greater than -1.25.
> Positive integers are 1, 2, 3, 4, ... (all are strictly greater than -1.25).
>
> 1 is positive and absent from the given array.
> ```
>
> **Example 3**
>
> ```text
> Input: @arr = (1, 2, 3)
> Output: 4
>
> Average: (1 + 2 + 3) / 3 = 2.0
> We need an integer strictly greater than 2.0.
>
> 3 is in the given array.
> 4 is not in.
> ```
>
> **Example 4**
>
> ```text
> Input: @arr = (2, 3, 7, 8)
> Output: 6
>
> Average: (2 + 3 + 7 + 8) / 4 = 5.0
> We need an integer strictly greater than 5.0.
>
> 6 is not in the given array.
> ```
>
> **Example 5**
>
> ```text
> Input: @arr = (1, 1, 1, 10)
> Output: 4
>
> Average: (1 + 1 + 1 + 10) / 4 = 3.25
> Positive integers strictly greater than 3.25: 4, 5, 6, ...
>
> 4 is not in the given array.
> ```

All input arrays in the examples are already sorted, but the
task description doesn't make this mandatory,
so let's sort the array first, just to be sure.

We are looking for the first integer that is strictly greater
than the average of the elements in the array,
and which itself does not occur in the array. In addition, that number must be positive. The first guess for the target number therefore is the first integer following that average. If the average is negative, we start with `1`, though:

```perl
    use List::Util qw( sum );
    my $avg = sum( @arr ) / @arr;
    my $target = $avg <= 0 ? 1 : int( $avg ) + 1;
```

Then, we loop over the (sorted) array elements, skipping all numbers that are smaller than our current target.

If we encounter an entry that is *larger* (but not equal) than our target, we know that our target is not present in the array, and can immediately return it as the result.

If we encounter an entry that is *equal* to our target, we increment the target and continue trying with the new value.

Once we reach the end of the array, we can safely return the current
target value, because we know it is larger than the last number in the array.

Putting everything together:

```perl
use v5.36;
use List::Util qw( sum );

sub absent_smallest_positive( @arr ) {
    @arr = sort { $a <=> $b } @arr;
    my $avg = sum( @arr ) / @arr;
    my $target = $avg <= 0 ? 1 : int( $avg ) + 1;
    for ( @arr ) {
        return $target if $_ > $target;
        ++$target if $_ == $target;
    }
    return $target;
}
```

## Task 2: Binary Reflection

> You are given an array of integer.<br/>
> Write a script to sort the given array in ascending order based on the binary reflection of each element. If two different numbers have the same binary reflection, the smaller original number should appear first.
>
> **Example 1**
>
> ```text
> Input: @arr = (3, 6, 12)
> Output: (3, 6, 12)
>
> Decimal 3  = Binary 11 -> reverse is also same 11 = Decimal 3
> Decimal 6  = Binary 110 -> reverse 011 = Decimal 3
> Decimal 12 = Binary 1100 -> 0011 = Decimal 3
>
> All three elements have the same binary reflection (3).
> Since they tie, they are sorted by their original values in ascending order: (3, 6, 12).
> ```
>
> **Example 2**
>
> ```text
> Input: @arr = (1, 2, 4, 8)
> Output: (1, 2, 4, 8)
>
> Decimal 1 = Binary 1 -> reverse is also same 1 = Decimal 1
> Decimal 2 = Binary 10 -> reverse is 01 = Decimal 1
> Decimal 4 = Binary 100 -> reverse 001 = Decimal 1
> Decimal 8 = Binary 1000 -> reverse is 0001 = Decimal 1
>
> All elements reflect to 1. Tie-breaking by original value yields (1, 2, 4, 8).
> ```
>
> **Example 3**
>
> ```text
> Input: @arr = (7, 8, 9, 10)
> Output: (8, 10, 7, 9)
>
> Decimal 8  = Binary 1000 -> reverse 0001 = Decimal 1
> Decimal 9  = Binary 1001 -> reverse 1001 = Decimal 9
> Decimal 10 = Binary 1010 -> reverse 0101 = Decimal 5
> Decimal 7  = Binary 111 -> reverse 111 = Decimal 7
>
> Binary reflections:
> 8  -> 1
> 9  -> 9
> 10 -> 5
> 7  -> 7
>
> Sorting by reflection values (1, 5, 7, 9) gives original elements (8, 10, 7, 9).
> ```
>
> **Example 4**
>
> ```text
> Input: @arr = (5, 9, 15, 17)
> Output: (5, 9, 15, 17)
>
> Decimal 5  = Binary 101 -> reverse 101 = Decimal 5
> Decimal 9  = Binary 1001 -> reverse 1001 = Decimal 9
> Decimal 15 = Binary 1111 -> reverse 1111 = Decimal 15
> Decimal 17 = Binary 10001 -> reverse 10001 = Decimal 17
>
> All numbers are binary palindromes, so their reflections match their original decimal values (5, 9, 15, 17),
> leaving the array order unchanged.
> ```
>
> **Example 5**
>
> ```text
> Input: @arr = (11, 13, 14, 19)
> Output: (14, 13, 11, 19)
>
> Decimal 11 = Binary 1011 -> reverse 1101 = Decimal 13
> Decimal 13 = Binary 1101 -> reverse 1011 = Decimal 11
> Decimal 14 = Binary 1110 -> reverse 0111 = Decimal 7
> Decimal 19 = Binary 10011 -> reverse 11001 = Decimal 25
>
> Reflections:
> 14 -> 7
> 13 -> 11
> 11 -> 13
> 19 -> 25
>
> Sorted by reflection values (7, 11, 13, 25) yields (14, 13, 11, 19).
> ```

Actually, there are two challenges to solve in this task:

* how to calculate the 'reverse binary' for a given number,
* how to sort the array of numbers according to a criterion that is not the number itself.

Let's have a look at the first one:

Reversing the bits of a number can be done in Perl using a sequence of `pack` and `unpack` calls, but most of the time, these calls work on chunks of eight bits, so we will end up shifting values around to remove leading binary zeros.

If performance were important, I would try the `pack`/`unpack` approach and benchmark it to see how well it performs. But for a solution that only needs to cover the small examples that we have, I choose something that is much less complicated, maybe even elegant:

* A string with the binary representation of a number can be produced with `sprintf "%b", $number`, that's easy enough.

* Reversing that string can be done using `reverse` (in scalar context!).

* For transforming the reversed string of `0`s and `1`s back into a number, we can use Perl's builtin `oct` function. We prepend `0b` to our string, and `oct` returns the expected value.

I created a little function for this:

```perl
sub reflected( $n ) {
    return oct "0b" . reverse sprintf( "%b", $n );
}
```

For the second part, sorting the array using special criteria, I use a well-known Perl idiom: the [*Schwartzian Transform*](https://en.wikipedia.org/wiki/Schwartzian_transform).

The idea is to transform every array element into an anonymous array containing the original value and the value that we want to use for sorting (the *key*). The computation of the key needs to be done only once for each element in the array. Then, in sorting, the *key* can be used as a sorting criterion. After the sorting step, the original values are extracted from the sorted two-element arrays, delivering the values in sorted order.

In our case, the key is computed using the `reflected` function above. The advantage of doing a *Schwartzian Transform* over calling `reflected` inside the `sort` comparison code block is that the number of calls is reduced to only one call per array element, as opposed to two calls per comparison when used in the `sort` code block.

The two-element anonymous arrays are set up using `map [ $_, reflected $_ ], @arr`. The comparison code block then can use another Perl idiom for concisely chaining comparisons:

```perl
    sort { $a->[1] <=> $b->[1] || $a->[0] <=> $b->[0] } ...
```

If the first comparison returns `0`, meaning that the reflection values are equal, the second comparison is evaluated and determines the order of the two elements.

Together with the `reflected` function definition above, this is my complete solution:

```perl
use v5.36;

sub reflected( $n ) {
    return oct "0b" . reverse sprintf( "%b", $n );
}

sub binary_reflection( @arr ) {
    return map $_->[0],
        sort { $a->[1] <=> $b->[1] || $a->[0] <=> $b->[0] }
            map [ $_, reflected $_ ],
                @arr;
}
```

#### **Thank you for the challenge!**
