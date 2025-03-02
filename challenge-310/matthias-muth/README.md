# Make it even.

**Challenge 310 solutions in Perl by Matthias Muth**

## Task 1: Arrays Intersection

> You are given a list of array of integers.<br/>
> Write a script to return the common elements in all the arrays.
>
> **Example 1**
>
> ```text
> Input: $list = ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )
> Output: (1, 4)
> ```
>
> **Example 2**
>
> ```text
> Input: $list = ( [1, 0, 2, 3], [2, 4, 5] )
> Output: (2)
> ```
>
> **Example 3**
>
> ```text
> Input: $list = ( [1, 2, 3], [4, 5], [6] )
> Output: ()
> ```

**CPAN makes it a one-liner**

This is a one-liner if we use the `Set::Intersection` CPAN module. Its `get_intersection` function takes a list of array-refs, which we have, and returns the list of elements that appear in all of those arrays. Bingo.

The only thing we need to add is to sort the result, so that the order of element matches what is expected in the examples. This is because `get_intersection` returns the common elements 'uniqued and unordered': 

```perl
use v5.36;

use Set::Intersection;

sub arrays_intersection( $list ) {
    return sort { $a <=> $b } get_intersection( $list->@* );
}
```

**And what about 'core-only'?**

My  'core-only' version is only a few lines of code, too.<br/>
First, every list of numbers is turned into an 'existence hash'
(which basically implement the notion of a 'set').<br/>
Then, `grep` checks for each number in the first set whether it exists in all others,
using `all` from `List::Utils`.
The result is returned after sorting it numerically.<br/>
Voilà!

```perl
use v5.36;

use List::Util qw( all );

sub arrays_intersection( $list ) {
    my @sets = map {
        { map { ( $_ => 1 ) } $_->@* }
    } $list->@*;
    return sort { $a <=> $b }
        grep {
            my $candidate = $_;
            all { $sets[$_]{$candidate} } 1..$#sets;
        } keys $sets[0]->%*;
}
```

## Task 2: Sort Odd Even

> You are given an array of integers.<br/>
> Write a script to sort odd index elements in decreasing order and even index elements in increasing order in the given array.
>
> **Example 1**
>
> ```text
> Input: @ints = (4, 1, 2, 3)
> Output: (2, 3, 4, 1)
>
> Even index elements: 4, 2 => 2, 4 (increasing order)
> Odd index elements : 1, 3 => 3, 1 (decreasing order)
> ```
>
> **Example 2**
>
> ```text
> Input: @ints = (3, 1)
> Output: (3, 1)
> ```
>
> **Example 3**
>
> ```text
> Input: @ints = (5, 3, 2, 1, 4)
> Output: (2, 3, 4, 1, 5)
>
> Even index elements: 5, 2, 4 => 2, 4, 5 (increasing order)
> Odd index elements : 3, 1 => 3, 1 (decreasing order)
> ```

I think it would be quite difficult to sort the even and odd elements
separately 'in place' in the same array.
It will be best to separate the evens and the odds, sort them separately,
and then reassemble the sorted arrays for the result.<br/>
Let's do that.

**It's nice to slice**

First step, separating the even and odd elements.<br/>
In Perl, we can use 'slices' to access selected parts of a list, an array or a hash.
We can use that to give the list of even indexes or odd indexes
to extract the numbers we need.
I use `grep` to select only the even, or only the odd indexes.
We can do the sorting right away. 
```perl
    my @even = sort { $a <=> $b } @ints[ grep $_ % 2 == 0,  keys @ints ];
    my @odd  = sort { $b <=> $a } @ints[ grep $_ % 2 != 0,  keys @ints ];
```
I'm using `keys @ints` instead of the more traditional `0..$#ints`,
because I find it easier to type. &#x1F609;

**Let's get together again**

For reassembling the `@even` and `@odd` arrays,
I immediately thought of the `zip` function from `List::Util`.
But actually, it produces a list of array references
with elements from the arrays given as parameter.
That's not exactly what we need.
But it's sibling `mesh` returns the combined elements as a flat list.
Very good, so let's do that:

```perl
    return mesh \@even, \@odd;
```

Very nice, but Oops!, it doesn't work for the third example.

When we have an odd number of elements in the `@ints` array,
the `@even` and `@odd` arrays will not have the same size.
There will be one additional element in the `@even` array—the last element from `@ints`. 

In that case, `mesh` returns us an additional `undef` in the last pair of elements, which ends up in our result where it shouldn't.

What we can do is to limit the result to the needed number of elements,
which is the same as in the original `@ints` array.
We can use a 'slice' again for that, easily:

```perl
    return ( mesh \@even, \@odd )[ keys @ints ];
```

This works for all examples now.

The only thing that I don't like about it is that probably,
to get rid of that additional `undef`,
internally the whole array has to be copied again for the result.
Choosing between 'programming effort' and 'computing effort',
I tend to try to avoid that computing overhead.
(Also, it's not really elegant to produce something,
only to throw it away immediately afterwards.)   

So looking for an alternative to the `mesh` solution.<br/>
Let's do the 'meshing' ourselves!

We can use `map` to create the list of even and odd index elements
from the two arrays, very easily:

```perl
        map { ( $even[$_], $odd[$_] ) } keys @odd
```

And for the 'dangling' element we get when `@int` contains an odd number of elements?<br/>
That last element will always be in the `@even` array,
because all index pairs are '(even, odd)'.<br/>
So we simple can add the last element of the `@even` array
in case it is longer than the `@odd` array:

```perl
    return
        map( { ( $even[$_], $odd[$_] ) } keys @odd ),
        @even > @odd ? $even[-1] : ();
```
That gives me a better feeling, efficiency-wise.

The complete solution then is this:
```perl
use v5.36;

sub sort_odd_even( @ints ) {
    my @even = sort { $a <=> $b } @ints[ grep $_ % 2 == 0,  keys @ints ];
    my @odd  = sort { $b <=> $a } @ints[ grep $_ % 2 != 0,  keys @ints ];
    return
        map( { $even[$_], $odd[$_] } keys @odd ),
        @even > @odd ? $even[-1] : ();
}
```

#### **Thank you for the challenge!**