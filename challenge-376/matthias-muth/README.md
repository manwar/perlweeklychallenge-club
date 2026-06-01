# A Single Beauty

**Challenge 375 solutions in Perl by Matthias Muth**

## Task 1: Single Common Word

> You are given two array of strings.<br/>
> Write a script to return the number of strings that appear exactly once in each of the two given arrays. String comparison is case sensitive.
>
> **Example 1**
>
> ```text
> Input: @array1 = ("apple", "banana", "cherry")
>  @array2 = ("banana", "cherry", "date")
> Output: 2
> ```
>
> **Example 2**
>
> ```text
> Input: @array1 = ("a", "ab", "abc")
>  @array2 = ("a", "a", "ab", "abc")
> Output: 2
> 
> "a" appears once in @array1 but appears twice in @array2, therefore, not counted.
> ```
>
> **Example 3**
>
> ```text
> Input: @array1 = ("orange", "lemon")
>  @array2 = ("grape", "melon")
> Output: 0
> ```
>
> **Example 4**
>
> ```text
> Input: @array1 = ("test", "test", "demo")
>  @array2 = ("test", "demo", "demo")
> Output: 0
> ```
>
> **Example 5**
>
> ```text
> Input: @array1 = ("Hello", "world")
>  @array2 = ("hello", "world")
> Output: 1
> 
> String comparison is case sensitive.
> ```

I guess the easiest way to compare the strings is to make an inventory. As we also need to decide whether a string appears exactly one, we should also keep a count of each string. The solution for me is to use a hash for each array, and to use `frequency` (from `List::MoreUtils`) to do the counting.

After that, `grep` (in scalar context) can return the number of entries who show exactly one occurrence in both of the arrays. Going through the first array's frequencies, the condition is that the respective frequency is exactly `1` , and also the same entry in the second array's frequencies is exactly `1`. As we are not sure whether that second value exists at all, a defined-or with `0` makes sure that at least there is a numerical value to compare with in that case.

Using `==` as a chained comparison is a little 'Modern Perl' tweak.  

```perl
use v5.36;
use List::MoreUtils qw( frequency );

sub single_common_word( $array1, $array2 ) {
    my %freq1 = frequency $array1->@*;
    my %freq2 = frequency $array2->@*;
    return scalar grep { $freq1{$_} == 1 == ( $freq2{$_} // 0 ) } keys %freq1;
}
```

## Task 2: Find K-Beauty

> You are given a number and a digit (k).<br/>
> Write a script to find the K-Beauty of the given number. The K-Beauty of an integer number is defined as the number of substrings of given number when it is read as a string has length of ‘k’ and is a divisor of given number.
>
> **Example 1**
>
> ```text
> Input: $num = 240, $k = 2
> Output: 2
> 
> Substring with length 2:
> 24: 240 is divisible by 24
> 40: 240 is divisible by 40
> ```
>
> **Example 2**
>
> ```text
> Input: $num = 1020, $k = 2
> Output: 3
> 
> Substring with length 2:
> 10: 1020 is divisible by 10
> 02: 1020 is divisible by 2
> 20: 1020 is divisible by 20
> ```
>
> **Example 3**
>
> ```text
> Input: $num = 444, $k = 2
> Output: 0
> 
> Substring with length 2:
> First "44": 444 is not divisible by 44
> Second "44": 444 is not divisible by 44
> ```
>
> **Example 4**
>
> ```text
> Input: $num = 17, $k = 2
> Output: 1
> 
> Substring with length 2:
> 17: 17 is divisible by 17
> ```
>
> **Example 5**
>
> ```text
> Input: $num = 123, $k = 1
> Output: 2
> 
> Substring with length 1:
> 1: 123 is divisible by 1
> 2: 123 is not divisible by 2
> 3: 123 is divisible by 3
> ```

All substrings have the same length, `$k`. The first substring starts at position `0`, and the last possible one starts at position `length( $num ) - $k`. A substring is a divisor of the original number if the `%` remainder of the number divided by that substring is `0`. We can simply sum up the comparison results for all substrings (which have a numerical value of `1` if the comparison is true, and `0` if not).

That actually makes is a one-statement solution: 

```perl
use v5.36;
use List::Util qw( sum );

sub find_k_beauty( $num, $k ) {
    return sum(
        map $num % substr ( $num, $_, $k ) == 0,
            0 .. length( $num ) - $k
    );
}
```

#### **Thank you for the challenge!**
