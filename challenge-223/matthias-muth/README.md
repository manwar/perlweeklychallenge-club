# Lazy, Lazy, Lazy Again ...
**Challenge 222 solutions in Perl by Matthias Muth**

## Task 1: Matching Members

> You are given a list of positive integers, @ints.<br/>
> Write a script to find the total matching members after sorting the list increasing order.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (1, 1, 4, 2, 1, 3)<br/>
> Output: 3<br/>
> Original list: (1, 1, 4, 2, 1, 2)<br/>
> Sorted list  : (1, 1, 1, 2, 3, 4)<br/>
> Compare the two lists, we found 3 matching members (1, 1, 2).<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (5, 1, 2, 3, 4)<br/>
> Output: 0<br/>
> Original list: (5, 1, 2, 3, 4)<br/>
> Sorted list  : (1, 2, 3, 4, 5)<br/>
> Compare the two lists, we found 0 matching members.<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (1, 2, 3, 4, 5)<br/>
> Output: 5<br/>
> Original list: (1, 2, 3, 4, 5)<br/>
> Sorted list  : (1, 2, 3, 4, 5)<br/>
> Compare the two lists, we found 5 matching members.<br/>

The examples help to understand that 'matching' here means that a number
in the original list
appears at the same position in the list after sorting the list in increasing order.
So the task actually is to compare the numbers in the original list
and in the sorted list at all positions.

I've written before that I am lazy sometimes.<br/>
So instead of typing all that is needed for a `for` loop to go through the listto 
(and making a lot of typing errors ;-) ), I prefer let `map` do the work.<br/>
Not only less typing, but also faster than an explicit for loop, I'm sure! :-)

What the `map` code block does is to compare the two numbers at the given position.
The comparison returns a Perl boolean value, which is 1 for true
and which evaluates to 0 in a numerical context (and to en empty string when used as a string).<br/>
So what we can do is to just sum up the `1`s that are returned by the comparison.
Easy to let List::Util's `sum` do that work (lazy again!).

So my short solution looks like this:

```perl
sub matching_members {
    my @ints = @_;
    my @sorted_ints = sort { $a <=> $b } @ints;
    return sum map { $ints[$_] == $sorted_ints[$_] } 0..$#ints;
}
```
'Lazy', short, but efficient!

## Task 2: Last Member

> You are given an array of positive integers, @ints.<br/>
> Write a script to find the last member if found otherwise return 0. Each turn pick 2 biggest members (x, y) then decide based on the following conditions, continue this until you are left with 1 member or none.<br/>
> a) if x == y then remove both members<br/>
> b) if x != y then remove both members and add new member (y-x)<br/>
> <br/>
> Example 1:<br/>
> <br/>
> Input: @ints = (2, 7, 4, 1, 8, 1)<br/>
> Output: 1<br/>
> <br/>
> Step 1: pick 7 and 8, we remove both and add new member 1 => (2, 4, 1, 1, 1).<br/>
> Step 2: pick 2 and 4, we remove both and add new member 2 => (2, 1, 1, 1).<br/>
> Step 3: pick 2 and 1, we remove both and add new member 1 => (1, 1, 1).<br/>
> Step 4: pick 1 and 1, we remove both => (1).<br/>
> <br/>
> Example 2:<br/>
> <br/>
> Input: @ints = (1)<br/>
> Output: 1<br/>
> <br/>
> Example 3:<br/>
> <br/>
> Input: @ints = (1, 1)<br/>
> Output: 0<br/>
> <br/>
> Step 1: pick 1 and 1, we remove both and we left with none.<br/>

This challenge is about reducing an array based on a condition,
until there is only one element left,
or even the last element was eliminated by the condition.
No tree searching or permutation calculations are needed,
so nothing that would warrant a recursive approach
(even though that would be possible),
we also don't need any backtracking whatsoever, so:<br/>
A simple loop will do.<br/>

We loop away array elements until we have left only one, or zero.
```perl
    while ( @ints >= 2 ) {
        ...;
    }
```

Then we are done, we return the only left element,
or a zero if there isn't a first element anymore.
'Lazy' again, we use the defined-ness of the existing first element
-- or rather the non-defined-ness of the non-existing element --,
together with Perl's wonderful 'defined-if' operator to shorten this:
```perl
   return exists $ints[0] ? $ints[0] : 0;
```
or this:
```perl
   return scalar @ints == 1 ? $ints[0] : 0;
```
into this:
```perl
   return $ints[0] // 0;
```
Looks very readable to me, and not a big chance for typing errors.

So what is happening *within* the loop?<br/>
The condition is to compare the largest two elements,
and based on the difference remove
both elements or replace them by the difference.

This time, we are ready to throw some more CPU in.
We could search the array for the largest and second largest number
(and remember their positions!),
and remove them both by building a new list from the existing one,
skipping the positions of the two numbers.

Oh. Alone the description is long anough to make me worry about typing errors again.

Instead, we use `sort` and `splice`.<br/>
Wait a second to see how short this is going to be!

First, we sort the array to have the highest numbers first:
```perl
    @ints = sort { $b <=> $a } @ints;
```
This is where the CPU might get some extra load.
With a O( n * log n ) complexity of good sorting algorithms
we might be slower than the O( n ) search that we could do.
But this will only be significant if we have *very* large numbers of elements to sort.<br/>
Thank you for the examples with no more than five elements!

So, `sort` it is! Largest numbers first.
```perl
	@ints = sort { $b <=> $a } @ints;
```

Then we get the difference between the largest numbers.<br/>
It will be non-negative because the first element is the largest.
```perl
	my $diff = $ints[0] - $ints[1];
```

And then, instead of building the reduced array element by element,
we use `splice` to do what we need.
And we add the difference, if it is non-zero, or nothing (an empty list), if it *is* zero,
in the same call.
```perl
	splice @ints, 0, 2, $diff || ();
```
That's all we need to do.

All together the solution looks like this:
```perl
sub last_member {
    my @ints = @_;

    while ( @ints >= 2 ) {
        # Sort the array, largest first.
        @ints = sort { $b <=> $a } @ints;

        # Get the difference between the first two elements
        # (it will be non-negative because the first element is the largest).
        my $diff = $ints[0] - $ints[1];

        # Replace the first two entries by their difference,
        # or by nothing if the difference is zero.
        splice @ints, 0, 2, $diff || ();
    }
    return $ints[0] // 0;
}
```

#### **Thank you for the challenge!**
