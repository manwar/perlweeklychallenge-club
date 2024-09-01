# Use `frequency` frequently!

**Challenge 284 solutions in Perl by Matthias Muth**

Making use of `frequency` from `List::MoreUtils` gives us nice and short results for both challenges!

## Task 1: Lucky Integer

> You are given an array of integers, @ints.<br/>
> Write a script to find the lucky integer if found otherwise return -1. If there are more than one then return the largest.<br/>
> A lucky integer is an integer that has a frequency in the array equal to its value.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (2, 2, 3, 4)<br/>
> Output: 2<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (1, 2, 2, 3, 3, 3)<br/>
> Output: 3<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (1, 1, 1, 3)<br/>
> Output: -1<br/>

For comparing the numbers in the `@ints` array to their own frequency in that array,
we need to compute the frequencies first.
Obviously.
`List::MoreUtils` is our friend, once again, because its `frequency` function does exactly that.
It returns a list of $( value, frequency )$ pairs,
which we can simply assign to a hash, and there we are.

Now we need to find the 'lucky integer',
and if we happen to find more than one we are supposed to return the highest one.
So we put together a chain:

* `grep` with a 'lucky' condition
  (the current number's frequency is the same as the number itself),
  applied on all existing numbers.<br/>
  We use `keys %freq` for the set of numbers, to make sure to check all numbers, but only once.
* Get the highest number of the result.<br/>
  Using `max` from `List::Util` for this.
* If there is no lucky number at all, `max` will return `undef`.<br/>
  We use the defined-or operator (`//`) to return a `-1` in that case.

So we got our solution in two lines of code:

```perl
use v5.36;
use List::MoreUtils qw( frequency );
use List::Util qw( max );

sub lucky_integer( @ints ) {
    my %freq = frequency( @ints );
    return max( grep $freq{$_} == $_, keys %freq ) // -1;
}
```

## Task 2: Relative Sort

> You are given two list of integers, @list1 and @list2. The elements in the @list2 are distinct and also in the @list1.<br/>
> Write a script to sort the elements in the @list1 such that the relative order of items in @list1 is same as in the @list2. Elements that is missing in @list2 should be placed at the end of @list1 in ascending order.<br/>
> <br/>
> Example 1<br/>
> Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)<br/>
>        @list2 = (2, 1, 4, 3, 5, 6)<br/>
> Ouput: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)<br/>
> <br/>
> Example 2<br/>
> Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)<br/>
>        @list2 = (1, 3, 2)<br/>
> Ouput: (1, 3, 3, 3, 2, 2, 4, 4, 6)<br/>
> <br/>
> Example 3<br/>
> Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)<br/>
>        @list2 = (1, 0, 3, 2)<br/>
> Ouput: (1, 1, 1, 0, 0, 3, 2, 4, 5)<br/>

Seems that our result set consists of two parts:

* first, all numbers from `@list1` that also are in `@list2`, in the order that is given by `@list2`,
* then, the numbers that are *not* in `@list2`, sorted in ascending order, from low to high.

We will put the two parts together in the end, but first we need to find a way to construct each of them.

For the numbers 'in the order of `@list2`', we actually can *use* `@list2`. That already gives us each number once, and for sure they are in the correct order!<br/>
We only need to *repeat* each number as many times as it appears in `@list1`.

So we are back to counting numbers again, and again, we use the `frequency` function from `List::MoreUtils` to keep it short.<br/>The first part of our result then simply is each number from `@list2`, repeated by its frequency in `@list1`:

```perl
    my %freq1 = frequency( $list1->@* );
    map( ( $_ ) x $freq1{$_}, $list2->@* )
```

For the second part, we need to use `@list1`, but exclude the numbers from `@list2`, because we already have dealt with those.

For simplicity, I use `frequency` again to built an 'existence hash' for `@list2`. Knowing that every number there appears only once, all the frequencies will be 1, but that's exactly what I need.

The second part then is `@list1`, with any element `grep`ped away that exists in `@list2`, then sorted numerically:

```Perl
    my %exists2 = frequency( $list2->@* );
    sort { $a <=> $b } grep ! $exists2{$_}, $list1->@*
```

Which gives us a solution with a high frequency of `frequency`. :-)

```perl
use v5.36;
use List::MoreUtils qw( frequency );

sub relative_sort( $list1, $list2 ) {
    my %freq1   = frequency( $list1->@* );
    my %exists2 = frequency( $list2->@* );
    return
        map( ( $_ ) x $freq1{$_}, $list2->@* ),
        sort { $a <=> $b } grep ! $exists2{$_}, $list1->@*;
}
```

#### **Thank you for the challenge!**
