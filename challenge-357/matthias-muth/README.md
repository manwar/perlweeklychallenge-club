# One Constant, and Many Fractions

**Challenge 357 solutions in Perl by Matthias Muth**

## Task 1: Kaprekar Constant

> Write a function that takes a 4-digit integer and returns how many iterations are required to reach Kaprekar’s constant (6174). For more information about Kaprekar's Constant please follow the wikipedia page.
>
> **Example 1**
>
> ```text
> Input: $int = 3524
> Output: 3
> 
> Iteration 1: 5432 - 2345 = 3087
> Iteration 2: 8730 - 0378 = 8352
> Iteration 3: 8532 - 2358 = 6174
> ```
>
> **Example 2**
>
> ```text
> Input: $int = 6174
> Output: 0
> ```
>
> **Example 3**
>
> ```text
> Input: $int = 9998
> Output: 5
> 
> Iteration 1: 9998 - 8999 = 0999
> Iteration 2: 9990 - 0999 = 8991
> Iteration 3: 9981 - 1899 = 8082
> Iteration 4: 8820 - 0288 = 8532
> Iteration 5: 8532 - 2358 = 6174
> ```
>
> **Example 4**
>
> ```text
> Input: $int = 1001
> Output: 4
> 
> Iteration 1: 1100 - 0011 = 1089
> Iteration 2: 9810 - 0189 = 9621
> Iteration 3: 9621 - 1269 = 8352
> Iteration 4: 8532 - 2358 = 6174
> ```
>
> **Example 5**
>
> ```text
> Input: $int = 9000
> Output: 4
> 
> Iteration 1: 9000 - 0009 = 8991
> Iteration 2: 9981 - 1899 = 8082
> Iteration 3: 8820 - 0288 = 8532
> Iteration 4: 8532 - 2358 = 6174
> ```
>
> **Example 6**
>
> ```text
> Input: $int = 1111
> Output: -1
> 
> The sequence does not converge on 6174, so return -1.
> ```

We know that there will only be a limited number of iterations, but an 'endless' loop is a helpful construct here. The reason being that we have *two distinct* criteria to end the loop, and both need to be followed by different actions. I am talking about jumping out of the loop and returning from the subroutine when either the `$int` value has the magical value of `6174` (returning the number of iterations in that case), or `$int` has become zero (returning `-1` then).

The rest of the loop deals with calculating the next value:

*  add leading zeros to the current number if necessary (using `sprintf "%04d", $int`),
* split the number up into a list of digits (`split`),
* sort them (using `sort`, of course, and sorting single digits alphanumerically, as is the default, is OK here),
* join them back again to form a new number.

As the sort order is 'ascending', the new number is the smaller of the two numbers we need (so the 'second' one when we compute the difference). The bigger ('first') one we get by simply applying `reverse` on that smaller one.

This is my result:

```perl
use v5.36;

sub kaprekar_constant( $int ) {
    my $count = 0;
    while () {
        return $count if $int == 6174;
        return -1 if $int == 0;
        my $n2 = join "", sort split "", sprintf "%04d", $int;
        $int = reverse( $n2 ) - $n2;
        ++$count;
    }
}
```

## Task 2: Unique Fraction Generator

> Given a positive integer N, generate all unique fractions you can create using integers from 1 to N and follow the rules below:<br/>
> - Use numbers 1 through N only (no zero)<br/>
> - Create fractions like numerator/denominator<br/>
> - List them in ascending order (from smallest to largest)<br/>
> - If two fractions have the same value (like 1/2 and 2/4),<br/>
>   only show the one with the smallest numerator
>
> **Example 1**
>
> ```text
> Input: $int = 3
> Output: 1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1```
>
> **Example 2**
>
> ```text
> Input: $int = 4
> Output: 1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1
> ```
>
> **Example 3**
>
> ```text
> Input: $int = 1
> Output: 1/1
> ```
>
> **Example 4**
>
> ```text
> Input: $int = 6
> Output: 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4,
>         4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1,
>         5/2, 3/1, 4/1, 5/1, 6/1
> ```
>
> **Example 5**
>
> ```text
> Input: $int = 5
> Output: 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1,
>         5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1
> ```

My solution follows these thoughts:

* We need to generate all possible combinations of numerators and denominators, each from `1` to `$int`. Probably there's not much that can be optimized here, so a nested loop will do this time (so no of `use Algorithm::Combinatorics` or similar).
* We are supposed to reduce fractions of the same value to use the smallest possible denominator. For this, we divide both denominator and denominator by their *greatest common divisor* (gcd). `Math::Utils` contains a `gcd` function that makes this as simple as possible.
* The fractions shall be returned as strings in the end. For eliminating duplicate entries from reduced fractions, I use a hash, with the reduced fractions, in string form, like `"1/2"`, as keys.
* The function result consists of the keys of that hash. They only need to be sorted 'in ascending order' of the fraction values.
  Instead of splitting up the fraction string again to compute its value, I compute that value already when I create the the hash entry for a fraction, and store it as the hash value.<br/>
  To get the idea, the following would be added as the entry for 1/2: `( "1/2" => 0.5 )`.
* For the result list, we can sort the hash keys by their associated values, which is easily done in the `sort` code block.

This is my resulting solution:

```perluse v5.36;
use v5.36;
use Math::Utils qw( gcd );

sub unique_fraction_generator( $int ) {
    my %values;
    for my $num ( 1..$int ) {
        for my $denum ( 1..$int ) {
            my $gcd = gcd( $num, $denum );
            $values{ ( $num / $gcd ) . "/" . ( $denum / $gcd ) } =
                $num / $denum;
        }
    }
    return sort { $values{$a} <=> $values{$b} } keys %values;
}
```



#### **Thank you for the challenge!**
