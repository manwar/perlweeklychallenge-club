# Missing and Mad

**Challenge 327 solutions in Perl by Matthias Muth**

## Task 1: Missing Integers

> You are given an array of n integers.<br/>
> Write a script to find all the missing integers in the range 1..n in the given array.
>
> **Example 1**
>
> ```text
> Input: @ints = (1, 2, 1, 3, 2, 5)
> Output: (4, 6)
>
> The given array has 6 elements.
> So we are looking for integers in the range 1..6 in the given array.
> The missing integers: (4, 6)
>```
> 
>**Example 2**
> 
>```text
> Input: @ints = (1, 1, 1)
> Output: (2, 3)
> ```
>
> **Example 3**
>
> ```text
>Input: @ints = (2, 2, 1)
> Output: (3)
> ```

Checking whether an integer is *missing* is the same
as checking whether it *exists*, but with a negative result.<br/>
For checking whether an integer *exists*,
I use an '*existence hash*'. And this is my standard way of creating one:

```perl
    my %exists = map { ( $_ => 1 ) } @ints;
```

I can now check the numbers from `1` to `@ints`
(which in scalar context is the number of elements in `@ints`) 
for having an entry (or, more precisely, having *no* entry)
in the *existence hash*.<br/>
Letting `grep` do that work and directly returning the result
gives us this two-lines-of-code solution: 

```perl
use v5.36;

sub missing_integers( @ints ) {
    my %exists = map { ( $_ => 1 ) } @ints;
    return grep ! $exists{$_}, 1..@ints;
}
```

## Task 2: MAD

> You are given an array of distinct integers.<br/>
> Write a script to find all pairs of elements with minimum absolute difference (MAD) of any two elements.
>
> **Example 1**
>
> ```text
> Input: @ints = (4, 1, 2, 3)
> Output: [1,2], [2,3], [3,4]
>
> The minimum absolute difference is 1.
> Pairs with MAD: [1,2], [2,3], [3,4]
>
> ```
>
> **Example 2**
>
> ```text
> Input: @ints = (1, 3, 7, 11, 15)
> Output: [1,3]
>
> ```
>
> **Example 3**
>
> ```text
> Input: @ints = (1, 5, 3, 8)
> Output: [1,3], [3,5]
> ```

It is very tempting to read '*find all pairs*' and immediately start thinking about combinatorics and how go through 'all pairs'.

But that is not necessary.

The 'minimum absolute difference' will always be between two numbers that are next to each other. So let's first sort the numbers:

```perl
    @ints = sort { $a <=> $b } @ints;
```

Now it quite easy to find the 'minimum absolute difference',
because it has to be one of the differences between two neighboring numbers.<br/>
So if we now produce the list of all differences
between any two *neighboring* numbers
(for all numbers except for the last one),
the 'MAD' then will be the minimum of those differences.<br/>
We don't need to use `abs()`, because the numbers are already sorted,
so the second one is always greater than or equal to the first one,
and thus the difference is always non-negative.

I chose to put the differences into a separate array for clearness,
and also because I will use the them in the next step:

```perl
    my @diffs = map $ints[ $_ + 1 ] - $ints[$_], 0..( $#ints - 1 );
    my $min_diff = min( @diffs );    
```

Now that we have the 'MAD' (in `$min_diff`),
we need to extract all pairs of numbers
whose difference is equal to that 'MAD' .<br/>
We can use `grep` on the indexes of the `@diff` array
to find all entries that fulfill this condition.

As each of the indexes found also corresponds to
the position of the two numbers in the sorted array,
we can extract those two numbers
and put them into an anonymous array (letting `map` do that).
We can then directly return the resulting list.

Maybe it's easier to understand just reading the code:

```perl
    return
        map [ @ints[ $_, $_ + 1 ] ],
            grep $diffs[$_] == $min_diff,
                keys @diffs;
```

This completes my solution:

```perl
use v5.36;
use List::Util qw( min );

sub mad( @ints ) {
    @ints = sort { $a <=> $b } @ints;
    my @diffs = map $ints[ $_ + 1 ] - $ints[$_], 0..( $#ints - 1 );
    my $min_diff = min @diffs;
    return
        map [ @ints[ $_, $_ + 1 ] ],
            grep $diffs[$_] == $min_diff,
                keys @diffs;
}
```

If we had compared every number to every other, we would have needed $\frac{n  (n+1)}{2}$
iterations for computing and comparing that number of differences, resulting in an $O(n^2)$ runtime complexity.

This solution's runtime complexity is determined by the
`sort` operation, and there are only $(n-1)$  differences computed and compared, so the runtime complexity is $O(n \log n)$ .<br/>Glad that we can find MAD pairs in really large lists of numbers now...! :wink::smile:

#### **Thank you for the challenge!**

