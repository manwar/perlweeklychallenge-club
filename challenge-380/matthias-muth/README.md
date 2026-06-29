# Just Do It Yourself! 

**Challenge 379 solutions in Perl by Matthias Muth**

## Task 1: Reverse String

> You are given a string.<br/>
> Write a script to reverse the given string without using standard reverse function.
>
> **Example 1**
>
> ```text
> Input: $str = ""
> Output: ""
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "reverse the given string"
> Output: "gnirts nevig eht esrever"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "Perl is Awesome"
> Output: "emosewA si lreP"
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "v1.0.0-Beta!"
> Output: "!ateB-0.0.1v"
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "racecar"
> Output: "racecar"
> ```

It seemed obvious for me
that the most efficient way to construct the reversed string
is by starting with an empty string and then *adding* characters to it,
not by *prepending* characters to what we already have.

For the solution that is easiest to write,
I looked for a way to avoid indexing operations,
which always have a tendency to be off by one,
especially when you index from the end of a string.
The good thing is that `substr` with a negative position
counts from the end,
meaning that `-1` as a position
is the character at the end of the string.

This gives me my easy-write solution:<br/>
`substr( $str, -1, 1, "" )`
returns the last character,
and at the same time removes it from `$str`.
In the next iteration,
the same expression will then extract the next character from the end of the string.

Obviously, `$str` will be empty in the end,
so this is quite a destructive approach.<br/>
But here we go:   

```perl
use v5.36;

sub reverse_string_destructive( $str ) {
    my $reversed = "";
    $reversed .= substr( $str, -1, 1, "" )
        while length $str > 0;
    return $reversed;
}
```

Not only is this destructive for `$str`,
but the destruction also has a runtime cost.
Maybe it's better to avoid it, and do it the traditional 'indexing' way.

As we are not supposed to use `reverse`
(which would make it too easy to use the indexes in reverse order),
I count the indexes forward,
and use the position at `length( $str ) - $_`.
This gets me the last character when `$_` is `1`,
so the loop is `1 .. length( $str )`
(and not `0 .. length( $str ) - 1`):

```perl
use v5.36;

sub reverse_string_non_destructive( $str ) {
    my $reversed = "";
    $reversed .= substr( $str, length( $str ) - $_, 1 )
        for 1 .. length( $str );
    return $reversed;
}
```

**Footnote:**<br/>
After finishing my solution,
I realized that indexing with `length( $str ) - $_`
actually is the same as indexing with `-$_` directly.
But even if I used negative indexes for `substr` in my first approach,
it didn't cross my mind that I could simply use `-$_`. I only had this idea when I read
[James Curtis-Smith's solution on Facebook](https://www.facebook.com/groups/theweeklychallengegroup/permalink/1676688466915217/).<br/>
Thank you, James, kudos!

## Task 2: Armstrong Number

> You are given two integers, $base and $limit.<br/>
> Write a script to find all Armstrong numbers in base $base that are less than $limit.<br/>
> If raising each of the digits of a nonnegative integer to the power of the total number of digits, then taking the sum, equals the original number, it is an Armstrong number.
>
> **Example 1**
>
> ```text
> Input: $base = 10, $limit = 1000
> Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407)
> ```
>
> **Example 2**
>
> ```text
> Input: $base = 7, $limit = 1000
> Output: (0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250)
> ```
>
> **Example 3**
>
> ```text
> Input: $base = 16, $limit = 1000
> Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645)
> ```

Apparently, `$limit = 1000` means that
we can count from `0` to `1000` *in decimal*
and check whether each of those numbers, when converted into base `$base`, is an Armstrong number.

Looking for a way to transform a decimal number into an array of digits in another base, it seems that the `todigits( $number, $base )` function from `Math::Prime::Util` (on CPAN) works best.<br/>
(There also is the `to_base_num( $base )` method for `Math::BigInt` numbers, but allegedly it is much slower.)

One caveat: `todigits` returns an empty array for the number `0`, meaning it has no digits. But we actually need at least one digit of `0` to do the Armstrong check, so this is a .  

Checking if the number in `$_` is an Armstrong number is quite easy once we have that array of digits `@digits` in base `$base`:

```perl
    sum( map $_ ** scalar @digits, @digits ) == $_
```

So my first solution is this:

```perl
use v5.36;

use List::Util qw( sum );
use Math::Prime::Util qw( todigits );

sub armstrong_number_math_prime_util( $base, $limit ) {
    my @results;
    for ( 0..$limit ) {
        my @digits = $_ == 0 ? ( 0 ) : todigits( $_, $base );
        push @results, $_
            if sum( map $_ ** scalar @digits, @digits ) == $_;
    }
    return @results;
}
```

What bothers me a bit with this solution is that the power calculations of the same digits happen again and again. Consider checking the power sums for these numbers:

| Number         | Sum of powers                                      |
| -------------- | -------------------------------------------------- |
| $\mathbf{250}$ | $\mathbf{2}^3 + \mathbf{5}^3 + \mathbf{0}^3 = 133$ |
| $\mathbf{251}$ | $\mathbf{2}^3 + \mathbf{5}^3 + \mathbf{1}^3 = 134$ |
| $\mathbf{252}$ | $\mathbf{2}^3 + \mathbf{5}^3 + \mathbf{2}^3 = 141$ |
| $\mathbf{253}$ | $\mathbf{2}^3 + \mathbf{5}^3 + \mathbf{3}^3 = 160$ |
| $\mathbf{254}$ | $\mathbf{2}^3 + \mathbf{5}^3 + \mathbf{4}^3 = 197$ |
| $\mathbf{255}$ | $\mathbf{2}^3 + \mathbf{5}^3 + \mathbf{5}^3 = 258$ |
| $\mathbf{256}$ | $\mathbf{2}^3 + \mathbf{5}^3 + \mathbf{6}^3 = 349$ |
| $\mathbf{257}$ | $\mathbf{2}^3 + \mathbf{5}^3 + \mathbf{7}^3 = 476$ |
| $\mathbf{258}$ | $\mathbf{2}^3 + \mathbf{5}^3 + \mathbf{8}^3 = 645$ |
| $\mathbf{259}$ | $\mathbf{2}^3 + \mathbf{5}^3 + \mathbf{9}^3 = 862$ |

The hundreds and tens digits are raised to the power of 3 ten times, without the digits changing. Actually, the term $2^3$ is computed 100 times, for the numbers from 200 to 299.

I therefore took another approach that tries to avoid most of these repeated calculations:

Instead of incrementing each number and then doing a full conversion into a new array of digits, I increment the digits themselves, directly in the `@digits` array. This works like a counting machine: once an incremented digit's value reaches `$base`, it is reset to zero, and the next significant digit is incremented. Note that here, `$digits[0]` always contains the least significant digit (as opposed to what `todigits`returns in the previous approach).

Every digit's power value is kept in a second array, `@powers`. Whenever I increment a digit, only that digit's power value is recalculated (and it is also reset to zero when the digit is reset to zero).

This approach avoids both the repeated conversion of decimal numbers and the repeated power calculations.

It looks like this:

```perl
use v5.36;

use List::Util qw( sum );

sub armstrong_number_increment( $base, $limit ) {
    my @results;
    my @powers = my @digits = ( 0 );
    for my $n ( 0..$limit ) {
        push @results, $n
            if sum( @powers ) == $n;

        # Increment digits and powers,
        # starting with the least significant digit.
        my $pos = 0;
        while ( ++$digits[$pos] == $base ) {
            $digits[$pos] = $powers[$pos] = 0;
            ++$pos;
        }
        $powers[$pos] = $digits[$pos] ** scalar @digits;
    }
    return @results;
}
```

A little benchmark proves that this approach can save many computing cycles:

```text
                  Rate math_prime_util       increment
math_prime_util 1555/s              --            -54%
increment       3371/s            117%              --
```

It is more than twice as fast for bases like 10 or 16. The more digits we have, the bigger is the gain, which makes it run almost three times as fast for `$base == 2`:

```text
                  Rate math_prime_util       increment
math_prime_util  743/s              --            -65%
increment       2113/s            184%              --
```

My favorite solution!

#### **Thank you for the challenge!**
