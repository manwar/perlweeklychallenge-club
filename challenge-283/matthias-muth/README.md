# Find the function to find the numbers

**Challenge 283 solutions in Perl by Matthias Muth**

## Task 1: Unique Number

> You are given an array of integers, @ints, where every elements appears more than once except one element.<br/>
> Write a script to find the one element that appears exactly one time.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (3, 3, 1)<br/>
> Output: 1<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (3, 2, 4, 2, 4)<br/>
> Output: 3<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (1)<br/>
> Output: 1<br/>
> <br/>
> Example 4<br/>
> Input: @ints = (4, 3, 1, 1, 1, 4)<br/>
> Output: 3<br/>

Once again, we can let `List::MoreUtils` do the work for us.
In this case, we use its `singleton` function, which extracts and returns those elements from a list that exist *exactly once* in that list. So if there actually is 'one element that appears exactly one time', `singleton @ints` will return it as the first (and only!) element of the return values. Perfect!

The specification says we need to 'to find *the one* element that appears exactly one time'.<br/>
If we don't find *the one* element, we won't return anything. And my interpretation of '*the one*' is that if there is *more than one* such element, we should not return anything either.

So here we go:

```perl
use v5.36;

use List::MoreUtils qw( singleton );

sub unique_number( @ints ) {
    my @s = singleton( @ints );
    return @s == 1 ? $s[0] : ();
}
```

## Task 2: Digit Count Value

> You are given an array of positive integers, @ints.<br/>
> Write a script to return true if for every index i in the range 0 <= i < size of array, the digit i occurs exactly the \$ints[\$i] times in the given array otherwise return false.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (1, 2, 1, 0)<br/>
> Ouput: true<br/>
> \$ints[0] = 1, the digit 0 occurs exactly 1 time.<br/>
> \$ints[1] = 2, the digit 1 occurs exactly 2 times.<br/>
> \$ints[2] = 1, the digit 2 occurs exactly 1 time.<br/>
> \$ints[3] = 0, the digit 3 occurs 0 time.<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (0, 3, 0)<br/>
> Ouput: false<br/>
> \$ints[0] = 0, the digit 0 occurs 2 times rather than 0 time.<br/>
> \$ints[1] = 3, the digit 1 occurs 0 time rather than 3 times.<br/>
> \$ints[2] = 0, the digit 2 occurs exactly 0 time.<br/>

We need to count how often every number appears  in the array before we can compare those frequencies to the entries in the `@ints` array. I'm making it easy  using the `frequency` function, again from `List::MoreUtils`. It returns a list of ( value, frequency ) pairs, which can directly be assigned to a hash.

Once we have that frequency hash, we use `List::Util`'s `all` function to check all the needed equalities. Index values that don't appear in the `@int` array should have a frequency of zero. But as they are not seen, and therefore not counted at all, they don't even get an entry in the frequency hash.  We take care of these missing values by a 'defined-or' with a zero.

`all`'s return value then is our result. Easy enough!

```perl
use v5.36;

use List::MoreUtils qw( frequency );
use List::Util qw( all );

sub digit_count_value( @ints ) {
    my %f = frequency @ints;
    return all { ( $f{$_} // 0 ) == $ints[$_] } 0..$#ints;
}
```

#### **Thank you for the challenge!**
