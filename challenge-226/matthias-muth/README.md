# The Zero Shuffle
**Challenge 226 solutions in Perl by Matthias Muth**

## Task 1: Shuffle String

> You are given a string and an array of indices of same length as string.<br/>
> Write a script to return the string after re-arranging the indices in the correct order.<br/>
> Example 1<br/>
> <br/>
> Input: $string = 'lacelengh', @indices = (3,2,0,5,4,8,6,7,1)<br/>
> Output: 'challenge'<br/>
> <br/>
> Example 2<br/>
> Input: $string = 'rulepark', @indices = (4,7,3,1,0,5,2,6)<br/>
> Output: 'perlraku'<br/>

It took me a moment to understand
that the array of indices is not where the letters *come from*,
but where the letters *go to*. <br/>
So we could write something like this for a `$result` string:
```perl
    my $result = " " x $#{$indices};    # We need to initialize the full length.
    substr( $result, $indices->[$_], 1 ) = substr( $string, $_, 1 )
        for 0..$#{$indices};
```
or this for a `@result` array:
```perl
    my @results;
    $results[ $indices->[$_] ] = substr( $string, $_, 1 )
        for 0..$#{$indices};
```

But of course there is more than one way to do it. :-)<br/>
For example, we can switch from manipulating things one by one,
and work with whole lists instead.
Most often this results in shorter, more 'elegant' code,
because it is less cluttered with all the details needed just to do things repeatedly.
That's why very often this makes the code easier to understand.

For making the letters from the string available as a list,
we can use the common Perl idiom
```perl
    $string =~ /./g
```
or we can use the also very common (and faster) 
```perl
    split //, $string
```

For assigning the letters to the result array,
Perl has the wonderful array slice syntax,
that can not only retrieve selected parts of an array or list,
but also assign to selected elements of an array, even in random order.
Exactly what we need!

So actually we can
assign the letters to the given indexes
with just one assigment,
and solve the whole task with three lines of code.<br/>
```perl
use v5.36;

sub shuffle_string( $string, $indices ) {
    my @results;
    @results[ @$indices ] = split //, $string;
    return join "", @results;
}
```
And no loop, and no typo-prone `$#{$indices}`!

## Task 2: Zero Array

> You are given an array of non-negative integers, @ints.<br/>
> Write a script to return the minimum number of operations to make every element equal zero.<br/>
> In each operation, you are required to pick a positive number less than or equal to the smallest element in the array, then subtract that from each positive element in the array.<br/>
> <br/>
> Example 1:<br/>
> Input: @ints = (1, 5, 0, 3, 5)<br/>
> Output: 3<br/>
> operation 1: pick 1 => (0, 4, 0, 2, 4)<br/>
> operation 2: pick 2 => (0, 2, 0, 0, 2)<br/>
> operation 3: pick 2 => (0, 0, 0, 0, 0)<br/>
> <br/>
> Example 2:<br/>
> Input: @ints = (0)<br/>
> Output: 0<br/>
> <br/>
> Example 3:<br/>
> Input: @ints = (2, 1, 4, 0, 3)<br/>
> Output: 4<br/>
> operation 1: pick 1 => (1, 0, 3, 0, 2)<br/>
> operation 2: pick 1 => (0, 0, 2, 0, 1)<br/>
> operation 3: pick 1 => (0, 0, 1, 0, 0)<br/>
> operation 4: pick 1 => (0, 0, 0, 0, 0)<br/>

This task can be made a lot easier by a 'transformation'.<br/>
We transform the task itself. :-)

I tried to visualize what actually happens when we do the subtractions
that are described in the text.<br/>
I imagined all the numbers in a coordinate system.
The *x* axis corresponds to the indices,
and the *y* coordinate for each number is the number itself.<br/>
Like this, for Example 1:
```
@ints:              1  5  0  3  5
                    |  |  |  |  | 
  5 ................|. 5 .|..|. 5 .........
  4                 |     |  |
  3 ................|.....|. 3 ............
  2                 |     |
  1 ............... 1 ....|................
  0 _____________________ 0 _______________
index:              0  1  2  3  4
```
Everytime we do the subtraction to all positive numbers, we kind of 'cut away'
a horizontal slice of the diagram.<br/>
Of course, we get the minimum number of operations
when we cut only where there are numbers (at the dotted lines), not in between.

In the diagram we see that we need to cut once for each unique number in the array,
and we don't need to cut on the zero line, even if there may be numbers that are zero.

So actually, as we only need to return the *number* of operations needed,
and don't need to really execute them, our job is much easier:<br/>

> You are given an array of non-negative integers, @ints.<br/>
> Find the number of unique, non-zero numbers in the input array.<br/>

Oh! How easy!

```perl
use v5.36;
use List::Util qw( uniq );

sub zero_array( @ints ) {
    return scalar uniq grep $_ != 0, @ints;
}
```

#### **Thank you for the challenge!**
