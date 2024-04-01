# Challenge 261 tasks: Summing Up Two Short Challenge Elements
**Challenge 261 solutions in Perl by Matthias Muth**

This week's challenges are of the shorter type.
So I am trying to keep the description short as well.

## Task 1: Element Digit Sum

> You are given an array of integers, @ints.<br/>
> Write a script to evaluate the absolute difference between element and digit sum of the given array.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (1,2,3,45)<br/>
> Output: 36<br/>
> Element Sum: 1 + 2 + 3 + 45 = 51<br/>
> Digit Sum: 1 + 2 + 3 + 4 + 5 = 15<br/>
> Absolute Difference: | 51 - 15 | = 36<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (1,12,3)<br/>
> Output: 9<br/>
> Element Sum: 1 + 12 + 3 = 16<br/>
> Digit Sum: 1 + 1 + 2 + 3 = 7<br/>
> Absolute Difference: | 16 - 7 | = 9<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (1,2,3,4)<br/>
> Output: 0<br/>
> Element Sum: 1 + 2 + 3 + 4 = 10<br/>
> Digit Sum: 1 + 2 + 3 + 4 = 10<br/>
> Absolute Difference: | 10 - 10 | = 0<br/>
> <br/>
> Example 4<br/>
> Input: @ints = (236, 416, 336, 350)<br/>
> Output: 1296<br/>

Perl's implicit type conversions make it simple to split up the numbers
into digits.
All we have to do then is to compute the difference of the sum of the
numbers and the sum of the digits (using `sum` from `List::Util`),
and return the absolute value using the builtin `abs` function.

Nice and short.

```perl
use v5.36;
use List::Util qw( sum );

sub element_digit_sum( @ints ) {
    return abs( sum( @ints ) - sum( map split( "", $_ ), @ints ) );
}
```

## Task 2: Multiply by Two

> You are given an array of integers, @ints and an integer \$start.<br/>
> Write a script to do the followings:<br/>
> a) Look for \$start in the array @ints, if found multiply the number by 2<br/>
> b) If not found stop the process otherwise repeat<br/>
> <br/>
> In the end return the final value.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (5,3,6,1,12) and \$start = 3<br/>
> Output: 24<br/>
> Step 1: 3 is in the array so 3 x 2 = 6<br/>
> Step 2: 6 is in the array so 6 x 2 = 12<br/>
> Step 3: 12 is in the array so 12 x 2 = 24<br/>
> 24 is not found in the array so return 24.<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (1,2,4,3) and \$start = 1<br/>
> Output: 8<br/>
> Step 1: 1 is in the array so 1 x 2 = 2<br/>
> Step 2: 2 is in the array so 2 x 2 = 4<br/>
> Step 3: 4 is in the array so 4 x 2 = 8<br/>
> 8 is not found in the array so return 8.<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (5,6,7) and \$start = 2<br/>
> Output: 2<br/>
> 2 is not found in the array so return 2.<br/>

Whenever I read 'exists', or 'find in an array', the words 'USE A HASH'
start blinking in front of my inner eye.
So I obey.<br/>
One of several possible Perl idioms to create a lookup hash
containing each number as a key, then multiplying by two in a loop as long as
the current product exists in that hash, and then returning the product.

Nice and short as well.

```perl
use v5.36;

sub multiply_by_two( $ints, $start ) {
    my %set_of_ints = map { ( $_ => 1 ) } $ints->@*;
    my $product = $start;
    $product *= 2
	while exists $set_of_ints{$product};
    return $product;
}
```

#### **Thank you for the challenge!**
