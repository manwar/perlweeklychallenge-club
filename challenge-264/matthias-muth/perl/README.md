# Indexes and Items
**Challenge 263 solutions in Perl by Matthias Muth**

## Task 1: Target Index

> You are given an array of integers, @ints and a target element $k.<br/>
> Write a script to return the list of indices in the sorted array where the element is same as the given target element.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (1, 5, 3, 2, 4, 2), $k = 2<br/>
> Output: (1, 2)<br/>
> Sorted array: (1, 2, 2, 3, 4, 5)<br/>
> Target indices: (1, 2) as $ints[1] = 2 and $k[2] = 2<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (1, 2, 4, 3, 5), $k = 6<br/>
> Output: ()<br/>
> No element in the given array matching the given target.<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (5, 3, 2, 4, 2, 1), $k = 4<br/>
> Output: (4)<br/>
> Sorted array: (1, 2, 2, 3, 4, 5)<br/>
> Target index: (4) as $ints[4] = 4<br/>

I have chosen the straight-forward solution,
sticking to the instructions very closely:
`sort` the array, and `grep` the result for indexes where the
entry matches `$k`.

Not really spectacular...

```perl
use v5.36;

sub target_index( $ints, $k ) {
    my @ints = sort $ints->@*;
    return grep $ints[$_] == $k, 0..$#ints;
}
```

## Task 2: Merge Items

> You are given two 2-D array of positive integers, $items1 and $items2 where element is pair of (item_id, item_quantity).<br/>
> Write a script to return the merged items.<br/>
> <br/>
> Example 1<br/>
> Input: $items1 = [ [1,1], [2,1], [3,2] ]<br/>
>        $items2 = [ [2,2], [1,3] ]<br/>
> Output: [ [1,4], [2,3], [3,2] ]<br/>
> Item id (1) appears 2 times: [1,1] and [1,3]. Merged item now (1,4)<br/>
> Item id (2) appears 2 times: [2,1] and [2,2]. Merged item now (2,3)<br/>
> Item id (3) appears 1 time: [3,2]<br/>
> <br/>
> Example 2<br/>
> Input: $items1 = [ [1,2], [2,3], [1,3], [3,2] ]<br/>
>        $items2 = [ [3,1], [1,3] ]<br/>
> Output: [ [1,8], [2,3], [3,3] ]<br/>
> <br/>
> Example 3<br/>
> Input: $items1 = [ [1,1], [2,2], [3,3] ]<br/>
>        $items2 = [ [2,3], [2,4] ]<br/>
> Output: [ [1,1], [2,9], [3,3] ]<br/>

The first thought is to assign the first set of items to a hash, 
flattening the entries in the item list, like in
``` perl
    my %counts = map $_->@*, $items1->@*;
```
But this doesn't work, as this will just overwrite entries like `[1,2]` in
the second example by `[1,3]`, which appears later in the same list,
and not add the entries together.

So we really have to do an addition of all the entries of the `$items1` and
`$items2` lists in a loop.

The data structure that is expected as a result
is the same as the input structure:
a reference to an array of ( key, value ) pairs, each represented by a short,
two-entries anonymous array.
So we sort the resulting hash by keys to generate that,
and as we put the result into an anonymous array,
we can just return the resulting reference.


```perl
use v5.36;

sub merge_items( $items1, $items2 ) {
    my %counts;
    $counts{$_->[0]} += $_->[1]
	for $items1->@*, $items2->@*;
    return [ map [ $_, $counts{$_} ], sort keys %counts ];
}
```

#### **Thank you for the challenge!**
