# Pythagoras, Euclid and Prime Numbers
**Challenge 393 solutions in Perl by Matthias Muth**

## Task 1: Pythagoras Multiplied

> You are given a positive integer n.<br/>
> Find the number of all positive integer triplets (a, b, c) so that a^2 + b^2 = c^2 and a, b and c are integers <= n.
>
> **Example 1**
>
> ```text
> Input: $n = 20
> Output: 12
>
> (3,4,5),  (4,3,5),   (5,12,13),(6,8,10),
> (8,6,10), (8,15,17), (9,12,15),(12,5,13),
> (12,9,15),(12,16,20),(15,8,17),(16,12,20)
> ```
>
> **Example 2**
>
> ```text
> Input: $n = 7
> Output: 2
>
> (3,4,5),(4,3,5)
> ```
>
> **Example 3**
>
> ```text
> Input: $n = 1
> Output: 0
> ```
>
> **Example 4**
>
> ```text
> Input: $n = 15
> Output: 8
> ```
>
> **Example 5**
>
> ```text
> Input: $n = 30
> Output: 22
> ```

**Learning about Euclid's Formula**

Triples of positive integers $(a, b, c)$ with $a^2+b^2=c^2$ are called *Pythagorean triples*.

While reading about this type of triples on [Wikipedia](https://en.wikipedia.org/wiki/Pythagorean_triple), I came across  *[Euclid's Formula](https://en.wikipedia.org/wiki/Pythagorean_triple#Generating_a_triple)*, which states that for any positive integers $m$ and $n$ with  $m > n > 0$,

$\quad ( m^2 - n^2, \text{ } 2 m n, \text{ } m^2 + n ^2 )$

is a Pythagorean triple.

I also learned that this formula can produce *primitive Pythagorean triples*, which are triples that cannot be scaled down any more by dividing $(a, b, c)$ by the same integer number. To obtain only *primitive triples*, $m$ and $n$ have to be coprime (which means they don't have any common divisors except $1$), and exactly one of $m$ and $n$ must be even.

**Putting it into code**

This solution produces primitive triples only, using Euclid's formula,
and counts their k-fold multiples up to the given size limit.

I have put all explanations into comments this time:

```perl
use v5.36;
use Math::Prime::Util qw( gcd );

sub pythagoras_multiplied_euclid( $limit ) {
    my $count = 0;
    # For any m, a lower bound for the hypotenuse is m² + 1.
    # End the loop if that exceeds the limit.
    for ( my $m = 2; $m * $m + 1 <= $limit; $m++ ) {
        # Make n loop over odd numbers if m is even, and vice versa.
        for ( my $n = 1 + $m % 2; $n < $m; $n += 2 ) {
            # Only c is needed, for checking against the limit,
            # and for calculating the number of scaled up triples
            # whose hypotenuses stay within the limit.
            my $c = $m * $m + $n * $n;
            last if $c > $limit;        # Check against the limit.
            next if gcd( $m, $n ) != 1; # Make sure (m, n ) are coprime
                                        # for primitive triples.
            # Add all triples (k*a, k*b, k*c) that have k*c <= limit.
            # We don't need a loop for that, and we actually don't need
            # a or b either.
            $count += int( $limit / $c );
        }
    }
    # Both (a, b, c) and (b, a, c) count, and they are always distinct.
    # If a and b were equal, a²+b²=c² would mean 2a²=c²,
    # which does not have an integer solution because sqrt(2) is
    # irrational.
    return 2 * $count;
}
```

## Task 2: Prime Step

> You are given a string with English alphabetic characters only.<br/>
> What is the absolute difference of the sum of the ASCII values of the characters in the string to the nearest prime number?
>
> **Example 1**
>
> ```text
> Input: $str = "hello"
> Output: 9
>
> The ordinal values of "hello" are [104,101,108,108,111], summing up to 532.
> The nearest prime number to 532 is 523, resulting in an absolute difference of 9.
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "football"
> Output: 2
>
> Starting with the values [102,111,111,116,98,97,108,108] and the sum 841.
> We find 839 as the nearest prime number, so the difference is 2.
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "a"
> Output: 0
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "challenge"
> Output: 2
>
> The ordinal values of "challenge" are [99, 104, 97, 108, 108, 101, 110, 103, 101], which sum up to 931.
> The nearest prime number to 931 is 929, so the difference is 2.
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "perl"
> Output: 2
>
> The ordinal values of "perl" are [112, 101, 114, 108], summing up to 435.
> Nearest prime is 433, so the difference is 2.
> ```

Getting the sum of ASCII values of the characters in a string is very simple in Perl:

```perl
    use List::Util qw( sum );
    my $sum = sum( map { ord } split "", $str );
```

But in the next step, we have to deal with prime numbers. My favorite module in that area is `Math::Prime::Util`.

The 'nearest prime number' of our sum can actually be the sum itself, if it is a prime. So we check this first, using `is_prime( $sum )`.

If the sum is not prime itself, there are the `prev_prime` and `next_prime` functions that return the previous and the next prime, respectively. One of the two must be the closest, so we take the minimum of the two distances. There is no need for using the `abs()` function, because we know that `prev_prime( $sum )` is lower than `$sum`, and `next_prime( $sum )` is larger.

This is the whole (two-statement)  solution:

```perl
use v5.36;
use List::Util qw( sum min );
use Math::Prime::Util qw( is_prime prev_prime next_prime );

sub prime_step( $str ) {
    my $sum = sum( map { ord } split "", $str );
    return
        is_prime( $sum )
        ? 0
        : min ( $sum - prev_prime( $sum ), next_prime( $sum ) - $sum );
}
```

#### **Thank you for the challenge!**
