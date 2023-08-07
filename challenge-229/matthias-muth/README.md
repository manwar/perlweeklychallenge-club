# Fast empty arrays, and the non-unique meaning of 'unique'
**Challenge 228 Task 1 and 2 solutions in Perl by Matthias Muth**

## Task 1: Unique Sum

> You are given an array of integers.<br/>
> Write a script to find out the sum of unique elements in the given array.<br/>
> <br/>
> Example 1<br/>
> Input: @int = (2, 1, 3, 2)<br/>
> Output: 4<br/>
> In the given array we have 2 unique elements (1, 3).<br/>
> <br/>
> Example 2<br/>
> Input: @int = (1, 1, 1, 1)<br/>
> Output: 0<br/>
> In the given array no unique element found.<br/>
> <br/>
> Example 3<br/>
> Input: @int = (2, 1, 3, 4)<br/>
> Output: 10<br/>
> In the given array every element is unique.<br/>

I think that the lesson that this task wants to teach us is
that the word 'unique' has several distinct (pun intended!) meanings.<br/>
A Wikipedia search tells us this:
>Unique primarily refers to:<br/>
>    * Uniqueness, a state or condition wherein something is **unlike anything else**<br/>
>    * In mathematics and logic, a unique object is the **only object** with a certain property,
see Uniqueness quantification<br/>

(highlighting by me).

Most of the times when we talk about extracting 'the unique elements' of a list
we think Unix `sort | uniq`, and what we want to get is *every* number from the list,
but each one only once.<br/>
Actually this means that every number in our *resulting list* is 'unique',
in the sense that is exists only once.

But in this task, we are supposed to extract the numbers that exist only once
already in the *input list* (and thus are 'unique' there!).

So we cannot use `List::Util`'s `uniq` (or better `uniq_int`) function for this.<br/>
But going through the list of functions in `List::MoreUtils`,
we find the `singleton` function, which is exactly what we need.

So we can make our life simple:
```perl
use v5.36;
use List::Util qw( sum );
use List::MoreUtils qw( singleton );

sub unique_sum( @int ) {
    return sum( singleton @int ) // 0;
}
```
We make sure that we return a zero instead of `undef`
when `singleton` returns an empty list
and `sum` has nothing to sum up.

If you don't want to install `List::MoreUtils` from CPAN,
here is the more 'classical' solution
(still using `sum` from the `List::Util`core module):

```perl
use v5.36;
use List::Util qw( sum );

sub unique_sum_core_only( @int ) {
    my %frequencies;
    $frequencies{$_}++
        for @int;
    return sum(
        grep { $frequencies{$_} == 1 } keys %frequencies
    ) // 0;
}
```

## Task 2: Empty Array

> You are given an array of integers in which all elements are unique.<br/>
> Write a script to perform the following operations until the array is empty and return the total count of operations.<br/>
> &nbsp;&nbsp;&nbsp;&nbsp;If the first element is the smallest then remove it otherwise move it to the end.<br/>
> <br/>
> Example 1<br/>
> Input: @int = (3, 4, 2)<br/>
> Ouput: 5<br/>
> Operation 1: move 3 to the end: (4, 2, 3)<br/>
> Operation 2: move 4 to the end: (2, 3, 4)<br/>
> Operation 3: remove element 2: (3, 4)<br/>
> Operation 4: remove element 3: (4)<br/>
> Operation 5: remove element 4: ()<br/>
> <br/>
> Example 2<br/>
> Input: @int = (1, 2, 3)<br/>
> Ouput: 3<br/>
> Operation 1: remove element 1: (2, 3)<br/>
> Operation 2: remove element 2: (3)<br/>
> Operation 3: remove element 3: ()<br/>

Let's start with a literal implementation of the algorithm that is described.<br/>
We count the operations in `$n_ops`.<br/>
In a loop, we either shift the first element away, or we push it to the end.

```perl
use v5.36;
use List::Util qw( min );

sub empty_array_1( @int ) {
    my $n_ops = 0;
    while ( @int ) {
        $n_ops++;
        if ( $int[0] == min @int ) {
            shift @int;
        }
        else {
            push @int, shift @int;
        }
    }
    return $n_ops;
}
```

Looking closer at what is happening,
I find that all numbers from the start of the list up to the list's lowest number
are moved to the end, one by one, before then that lowest number is removed.<br/>
So why don't we do this in one single operation?

To do so, we need to find the index of the lowest number:
```perl
        my $min = $int[0];
        my $index = 0;
        for ( 1..$#int ) {
            if ( $int[$_] < $min ) {
                $index = $_;
                $min = $int[$_];
            }
        }
```
Actually, finding the index of a given element in the array is something that has been
invented and optimized before.
So let's use this version, which is much easier on the eyes
(sorry, I mean 'more readable and therefore more easily maintainable'):
```perl
        my $min = min @int;
        my $index = first_index { $_ == $min } @int;
```
Any of these two will work nicely.

But in fact, I don't like that we compute the minimum of the array again and again,
within each iteration of the loop.
And actually, the order in which elements are removed is from the lowest to the highest,
no matter how many operations it takes.
Which means that we can create a sorted copy of the array once,
and then process the 'lowest' numbers in that order.<br/>
Like this:
```perl
    my @sorted = sort { $a <=> $b } @int;
    for my $current_smallest ( @sorted ) {
        my $index = first_index { $_ == $current_smallest } @int;
        ...
    }
```

Now for moving the numbers in one step, we recreate the array,
from the numbers *right* of the smallest number,
and putting everything that was *left* of the smallest number behind.
We just need to be cautious about the edge case of having
*no* numbers to the left,
because `$index == 0` results in `$index - 1 == -1`,
which 'wraps around' in a most unwanted way.
```perl
        @int = (
            @int[ $index + 1 .. $#int ],
            $index > 0  ? @int[ 0 .. $index - 1 ] : (),
        );
```

Maybe the next step is a bit of overdoing it,
but I think it is still worth it.<br/>
The idea is to not recreate the array,
but to use a combination of `splice` and `push`
to modify the existing array.<br/>
The wanted effect is to use Perl's internal optimizations
for array operations, and to avoid copying the whole array
over and over again within each iteration.

So let's do it like that:
```perl
        # Move all numbers left of the smallest one to the end, in one step,
        # 'splicing' them away at the front and re-adding (push) them at the
        # end.
        # We only need to do that if there actually *are* any numbers left of
        # the smallest number.
        push @int, splice @int, 0, $index, ()
            if $index > 0;
```
After that, the smallest number is in the first position (always!),
and can be `shift`ed away.
```perl
        # Remove the smallest number, which is at the front now.
        shift @int;
```

This is the whole function now (leaving comments in the code).
```
use v5.36;
use List::Util qw( min );
use List::MoreUtils qw( first_index );

sub empty_array_5( @int ) {
    my $n_ops = 0;

    # Sort the numbers, to get the order in which we will remove them,
    # Then walk through the numbers, starting with the lowest one.
    my @sorted = sort { $a <=> $b } @int;
    for my $current_smallest ( @sorted ) {
        # Find the position of our smallest number in the array.
        my $index = first_index { $_ == $current_smallest } @int;

        # Move all numbers left of the smallest one to the end, in one step,
        # 'splicing' them away at the front and re-adding (push) them at the
        # end.
        # We only need to do this if there actually *are* any numbers left of
        # the smallest number.
        push @int, splice @int, 0, $index, ()
            if $index > 0;

        # Remove the smallest number, which is at the front now.
        shift @int;

        # What we did was worth '$index' single move operations, plus one
        # delete operation.
        $n_ops += $index + 1;
    }
    return $n_ops;
}
```

For the small examples that we have, I probably really over-optimized my solution.
But I ran a little benchmark, comparing the first version and the last one:
```
Benchmark using 10 values:
                  Rate empty_array_5 empty_array_1
empty_array_5  74734/s            --          -61%
empty_array_1 192152/s          157%            --

Benchmark using 50 values:
                Rate empty_array_1 empty_array_5
empty_array_1 3792/s            --          -25%
empty_array_5 5046/s           33%            --

Benchmark using 100 values:
                Rate empty_array_1 empty_array_5
empty_array_1  323/s            --          -84%
empty_array_5 1973/s          511%            --

Benchmark using 1000 values:
                s/iter empty_array_1 empty_array_5
empty_array_1     2.14            --          -99%
empty_array_5 3.14e-02         6717%            --
```

It turns out that for all challenge examples, the simple first version is more efficient!
This is probably due to the startup cost for sorting the array.<br/>
At around 50 elements, the 'optimized' version starts being faster.
And for a 1000 elements array, the simple version needs more than 2 seconds for one run on my laptop,
while the optimized version does it in 31.4 milliseconds.<br/>
More than 600 times faster!

It gives me a good feeling to have a PWC solution that scales so well! :-D

#### **Thank you for the challenge!**
