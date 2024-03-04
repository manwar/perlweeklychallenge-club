# You Only Grep Twice

**Challenge 258 solutions in Perl by Matthias Muth**

## Task 1: Count Even Digits Number

> You are given a array of positive integers, @ints.<br/>
> Write a script to find out how many integers have even number of digits.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (10, 1, 111, 24, 1000)<br/>
> Output: 3<br/>
> There are 3 integers having even digits i.e. 10, 24 and 1000.<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (111, 1, 11111)<br/>
> Output: 0<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (2, 8, 1024, 256)<br/>
> Output: 1<br/>

This is a small exercise for using `grep`.<br/>
We go through all values in the `@ints` array. For each value, we get the number of digits using the `length` function. Perl's type flexibility and implicit type conversion helps us here, in that the `length` returns the number of characters of the current value *as a string*.

We then check whether this number is even, using this as a filter for `grep`. 

When called in scalar context,  `grep` returns the number of values that fulfill the criteria, not the list of values itself. As we are only interested in this number, we call  `grep` in scalar context explicitly, and we are done.

Long explanation, short code:

```perl
use v5.36;
sub count_even_digits_number( @ints ) {
    return scalar grep length( $_ ) % 2 == 0, @ints;
}
```

## Task 2: Sum of Values

> You are given an array of integers, @int and an integer \$k.<br/>
> Write a script to find the sum of values whose index binary representation has exactly \$k number of 1-bit set.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (2, 5, 9, 11, 3), \$k = 1<br/>
> Output: 17<br/>
> Binary representation of index 0 = 0<br/>
> Binary representation of index 1 = 1<br/>
> Binary representation of index 2 = 10<br/>
> Binary representation of index 3 = 11<br/>
> Binary representation of index 4 = 100<br/>
> So the indices 1, 2 and 4 have total one 1-bit sets.<br/>
> Therefore the sum, \$ints[1] + \$ints[2] + \$ints[3] = 17<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (2, 5, 9, 11, 3), \$k = 2<br/>
> Output: 11<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (2, 5, 9, 11, 3), \$k = 0<br/>
> Output: 2<br/>

This looks very similar. We also can use `grep`to select the values that we process further.<br/>
But after reading the task again, and also checking the examples, we notice that in the filter, we don't use the numbers in the array, but the *index* of the numbers.

So what we do is to use `grep` again, but this time, we go through all indexes instead of the values, filtering on the number of 1-bits that the index has, and then `map`the filtered indexes back to their array values. Then we can `sum` up those values.

For getting the number of 1-bits in an integer number, probably the most efficient way is to use `unpack` with a `'%'` field prefix to do a checksum of the packed binary representation of our number (see examples in [perldoc](https://perldoc.perl.org/functions/unpack)). So for numbers at least up to 32 bits, this function does a marvelous job:

```perl
use v5.36;
sub n_bits( $n ) {
    return unpack "%b*", pack "i", $n;
}
```

(`use v5.36;` is the shortest way to get function prototypes, which I don't want to miss.)

The rest is straightforward:

```perl
use List::Util qw( sum );
sub sum_of_values( $ints, $k ) {
    return sum map $ints->[$_], grep n_bits( $_ ) == $k, 0..$ints->$#*;
}
```

#### **Thank you for the challenge!**

