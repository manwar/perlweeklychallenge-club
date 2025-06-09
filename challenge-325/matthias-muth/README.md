# Reduce and Reduce, and Reduce!

**Challenge 324 solutions in Perl by Matthias Muth**

## Task 1: 2D Array

> You are given an array of integers and two integers \$r and \$c.<br/>
> Write a script to create two dimension array having \$r rows and \$c columns using the given array.
>
> **Example 1**
>
> ```text
> Input: @ints = (1, 2, 3, 4), $r = 2, $c = 2
> Output: ([1, 2], [3, 4])
>```
> 
>**Example 2**
> 
>```text
> Input: @ints = (1, 2, 3), $r = 1, $c = 3
> Output: ([1, 2, 3])
> ```
>
> **Example 3**
>
> ```text
>Input: @ints = (1, 2, 3, 4), $r = 4, $c = 1
> Output: ([1], [2], [3], [4])
> ```

We have to walk through the input array steps of size `$c`,
copying row after row to an output array.<br/>

I started with a solution that is easy to implement.
Then I tried to **reduce the code**
(with the intention to keep it easy to understand),
and to **reduce the runtime**. 

My first solution uses the `natatime` function from `List::MoreUtils`,
which is built for just that:
walking through an array or a list
and extracting multiple entries in every iteration (hence the name, '$n$ at a time') .
The function creates an iterator, which we then use in a loop.<br/>
Quite simple:

```perl
use v5.36;
use List::MoreUtils qw( natatime );

sub two_d_array_natatime( $ints, $r, $c ) {
    my @matrix;
    my $iterator = natatime $c, $ints->@*;
    while ( my @row = $iterator->() ) {
        push @matrix, [ @row ];
    }
    return @matrix;
}
```

Then I started to think:<br/>
Calling the iterator function might be quite an overhead
over just keeping an index ourselves
and locating and returning a number of elements.
We still can use Perl's nice array slice operator
to extract a whole row of elements 'at a time'.

If we loop over the row indexes using `$_`,
each row's data start at index `$_ * $c`,
and it will end just before the next row,
which is at `( $_ + 1 ) * $c - 1` .<br/>
We also can use `map` instead of a `for` loop and `push`,
effectively eliminating the need of a result variable.
The row indexes run from `0` to `$r - 1 `.

That looks like this:

```perl
sub two_d_array_map( $ints, $r, $c ) {
    return map [ $ints->@[ $_ * $c .. ( $_  + 1 ) * $c - 1 ] ], 0 .. $r - 1;
}
```

This **reduces our code** a lot,
and I think it has not turned into anything unreadable.

At the same time, as very often, this also **reduces the runtime**
by avoiding several overheads.<br/>
I have run some small benchmarks,
for matrix sizes of 2x2, 4x4, 10x10, 100x100, and even 1000x1000:

```text
array size: 2 x 2
              Rate natatime      map
natatime  635496/s       --     -47%
map      1205315/s      90%       --
array size: 4 x 4
             Rate natatime      map
natatime 395930/s       --     -37%
map      631484/s      59%       --
array size: 10 x 10
             Rate natatime      map
natatime 127245/s       --     -32%
map      188504/s      48%       --
array size: 100 x 100
           Rate natatime      map
natatime 2045/s       --     -39%
map      3329/s      63%       --
array size: 1000 x 1000
           Rate natatime      map
natatime 21.0/s       --     -43%
map      37.0/s      76%       --
```

It shows that our Perlish home-brewed one-line-of-code solution
beats `natatime` at any array size.<br/>
I find it interesting that for medium sizes, the two solutions approach each other with respect to performance, but then with larger sizes, `map` performs better again.<br/>
I cannot really explain this effect. 
I would have guessed that for bigger matrices, most time is spent for really copying the data, so the way of controlling it becomes less important in general.

A quite simple task, yet a lot to learn.  



## Task 2: Total XOR

> You are given an array of integers.<br/>
> Write a script to return the sum of total XOR for every subset of given array.
>
> **Example 1**
>
> ```text
> Input: @ints = (1, 3)
> Output: 6
>
> Subset [1],    total XOR = 1
> Subset [3],    total XOR = 3
> Subset [1, 3], total XOR => 1 XOR 3 => 2
>
> Sum of total XOR => 1 + 3 + 2 => 6
>```
> 
>**Example 2**
> 
>```text
> Input: @ints = (5, 1, 6)
> Output: 28
> 
>Subset [5],       total XOR = 5
> Subset [1],       total XOR = 1
> Subset [6],       total XOR = 6
> Subset [5, 1],    total XOR => 5 XOR 1 => 4
> Subset [5, 6],    total XOR => 5 XOR 6 => 3
> Subset [1, 6],    total XOR => 1 XOR 6 => 7
> Subset [5, 1, 6], total XOR => 5 XOR 1 XOR 6 => 2
> 
>Sum of total XOR => 5 + 1 + 6 + 4 + 3 + 7 + 2 => 28
> ```
>
> **Example 3**
>
> ```text
>Input: @ints = (3, 4, 5, 6, 7, 8)
> Output: 480
> ```

There are these things we need to implement:

* get all possible subsets of the input data,
* compute the XOR sum of each subset,
* sum up and return the XOR sums.

For the first part, getting all subsets of a given set of elements,
it is easiest to use an existing and well tested piece of software from CPAN.
I used the `subsets` function from `Algorithm::Combinatorics`
for my first solution.
It returns an iterator that delivers the next subset with every call,
with the empty subset being the last.
The empty subset can then be used as an end criteria for the loop.

Simple as this:

```perl
use v5.36;
use Algorithm::Combinatorics qw( subsets );

sub total_xor( @ints ) {
    my $sum = 0;
    my $iterator = subsets( \@ints );
    while ( my $subset = $iterator->next ) {
        $sum += ...;	# Add XOR sum of the current subset.
    }
    return $sum;
}
```

**Reduce to the XOR sum** 

But how do we compute the XOR sum of a list of numbers?

Traditional thinking would use a loop for this.<br/>
But let's think a bit more 'functional' today.<br/>
The **`reduce`** function is the perfect choice
for walking through a list and building up a final result
by combining elements one by one.<br/>
Its code block combines the current partial result
(in the `$a` special variable) with the next element (in `$b`).
In the end, all the elements will have been combined.

We start with a `0` as the first element,
to not get an `undef` result for the empty subset.<br/>
Our implementation of an 'XOR sum' function is simply this:

```perl
    reduce { $a ^ $b } 0, @elements
```

So here is the complete (first) solution:

```perl
use v5.36;
use Algorithm::Combinatorics qw( subsets );
use List::Util qw( reduce );

sub total_xor( @ints ) {
    my $sum = 0;
    my $iterator = subsets( \@ints );
    while ( my $subset = $iterator->next ) {
        $sum += reduce { $a ^ $b } 0, $subset->@*;
    }
    return $sum;
}
```

**BONUS: Roll your own subset iterator:**

I was wondering how difficult it would be to implement the `subsets` iterator myself.<br/>Actually it isn't!

The theory behind creating all possible subsets is this:

Every possible subset of a set with $n$ elements is determined
by which of the elements are contained or not.<br/>
If we use one bit $b_i$ to represent whether element $i$ is contained or not,
the bits form a number between $0$ (for the empty set) and $2^n - 1$
(all bits set, all elements contained in that subset, which is the set itself).<br/>
We can enumerate the subsets using that number, calling it a 'subset id'<br/>
The overall number of possible subsets is $2^n$.

For the creation of our iterator,
we initialize a `$subset_id` variable with $2^n$.<br/>
I know, that's one too high,
but it's actually easier to pre-decrement this variable within the iterator:<br/>
This way, we can at the same time determine whether we have
reached the end of the possible subsets, return `undef` if so,
and continue to directly return the result if not.<br/>
If the `$subset_id` already is zero upon entry,
we have returned the last subset (the empty one) in the previous call.
We then set the `$subset_id` to `undef`,
and return that value from this and all following calls to this iterator.

If we are still good, we determine the elements of the subset,
based on the bits set or not set in `$subset_id`.<br/>
This is done by `map`ping the element indexes to a one-bit
shifted into the corresponding position,
and doing a bitwise And with the subset_id.
If the bit is set,
we include the element into the anonymous array that will be returned. 

So, here is my bonus subset iterator. 

```perl
sub subset_iterator( $ints ) {
    my $subset_id = 1 << $ints->@*;
    return sub() {
        return defined ( $subset_id ? --$subset_id : undef )
            && [ map $subset_id & 1 << $_ ? $ints->[$_] : (), keys $ints->@* ];
    };
}
```

Just make sure that your set doesn't contain more than 63 elements... ;-)


#### **Thank you for the challenge!**
