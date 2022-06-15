[< Previous 168](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-168/james-smith) |
[Next 170 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-170/james-smith)

# The Weekly Challenge 169

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-169/james-smith

# Challenge 1 - Brilliant numbers 

***Write a script to generate first 20 Brilliant Numbers.  Brilliant numbers are numbers with two prime factors of the same length.  The number should have exactly two prime factors, i.e. it’s the product of two primes of the same length.***


## Solution

Again our favoured prime package `Math::Prime::Util` has the method we need `factor` which returns a list of prime factors, and its fast - especially for the magnitude of numbers we are looking at.

We loop through all numbers, checking to see if (a) the number has exactly 2 prime factors and they are the same length.

For flexibility we define the max count `$MAX` as the command-line argument if one is supplied (or 100 if not).

```perl
for( my( $n, $c, $MAX, @f ) = ( 0, 0, @ARGV ? $ARGV[0] : 1e2 ); $c<$MAX; $n++ ) {
  say sprintf '%7d: %10d = %5d x %d', ++$c, $n, @f if 2 == ( @f = factor $n ) && length $f[0] == length $f[1];
}
```

This logic is wrapped up int the single `if`. As we check the number of factors, we store these in an array, so that we can check the 2nd condition.

The output in each row is the brilliant number and the two primes which are it's factors.

**Note:** Both in this and the next challenge we utilise a classic "c-style" `for`-loop. This construct allows us to combine the variable initialized (and declaration), the end condition, and the increment of the number into a single statement. We code rewrite this a postfix `for(each)` in this case, but would need an declaration/initialisation statement for `$n` and `@f` anyway. Also in challenge 2 it isn't possible to use a postfix for `for` as this doesn't allow us to use the `next` trick to short cut the `grep` inside the `gcd` call.

**Note:** to make the code easier to read we use a *Yoda* condition, where we reverse the value and the code evaluation - so instead if say `$a == 2` we say `2 == $a`.

**Moan:** Why is there no `sayf` function similar to `printf` - using `say sprintf` seems a bit "messy" each time...

```
       1:          4 =     2 x 2
       2:          6 =     2 x 3
       3:          9 =     3 x 3
       4:         10 =     2 x 5
       5:         14 =     2 x 7
       6:         15 =     3 x 5
       7:         21 =     3 x 7
       8:         25 =     5 x 5
       9:         35 =     5 x 7
      10:         49 =     7 x 7
      11:        121 =    11 x 11
      12:        143 =    11 x 13
      13:        169 =    13 x 13
      14:        187 =    11 x 17
      15:        209 =    11 x 19
      16:        221 =    13 x 17
      17:        247 =    13 x 19
      18:        253 =    11 x 23
      19:        289 =    17 x 17
      20:        299 =    13 x 23
      21:        319 =    11 x 29
      22:        323 =    17 x 19
      23:        341 =    11 x 31
      24:        361 =    19 x 19
      25:        377 =    13 x 29
      26:        391 =    17 x 23
      27:        403 =    13 x 31
      28:        407 =    11 x 37
      29:        437 =    19 x 23
      30:        451 =    11 x 41
      31:        473 =    11 x 43
      32:        481 =    13 x 37
      33:        493 =    17 x 29
      34:        517 =    11 x 47
      35:        527 =    17 x 31
      36:        529 =    23 x 23
      37:        533 =    13 x 41
      38:        551 =    19 x 29
      39:        559 =    13 x 43
      40:        583 =    11 x 53
      41:        589 =    19 x 31
      42:        611 =    13 x 47
      43:        629 =    17 x 37
      44:        649 =    11 x 59
      45:        667 =    23 x 29
      46:        671 =    11 x 61
      47:        689 =    13 x 53
      48:        697 =    17 x 41
      49:        703 =    19 x 37
      50:        713 =    23 x 31
```

### Removing pretty print

If we remove the pretty print this reduces to:

```perl
for( my( $n, $c, $MAX, @f ) = ( 0, 0, @ARGV ? $ARGV[0] : 1e2 ); $c<$MAX; $n++ ) {
  $c++, say $n if 2 == ( @f = factor $n ) && length $f[0] == length $f[1];
}
```

# Challenge 2 - Achilles Number

***Write a script to generate first 20 Achilles Numbers. An Achilles number is a number that is powerful but imperfect (not a perfect power). Named after Achilles, a hero of the Trojan war, who was also powerful but imperfect.***

*A positive integer `n` is a powerful number if, for every prime factor `p` of `n`, `p^2` is also a divisor.*

*A number is a perfect power if it has any integer ropts ( square, cube, ... ) i.e. can be written in the form `n^m`.*

*An imperfect number is one which can't be - now this means that if we make a prime factorization of the form `p1^k1 . p2^k2 . p3^k3 ....` then the greatest common divisor is 1. As if greater than 1 then we could write this as `( p1^k1/gcd . p2^k2/gcd . p3^k3/gcd . ... )^gcd` and so would be perfect.

## Solution

Again `Math::Prime::Util` has the two methods we need `factor_exp` and `gcd`. The former a modification to `factor` returns a list of tuples, each containing the prime and its exponent so rather than returning say `2, 2, 2, 3, 3` it returns `[2, 3], [3, 2]`. The latter a function we haven't used before takes a list of numbers and computes there greatest common divisor. This simplfies the problem... for each value we generate a hash of their prime factors, the key being the prime and the value the power (using `factor`)

We then check to see if any of the factors does not have its square as a factor. We do this in the grep - by using `next` we jump out of the `map` back to the next entry in the `for` loop.

We then compute the `gcd` of these powers - if it is 1 then we display the result - our output is index, value and the prime factorisation, most of the loop is for the pretty print.

```perl
for( my( $n, $c, $MAX, @f ) = ( 2, 0, @ARGV ? $ARGV[0] : 1e2 ); $c < $MAX; $n++ ) {
  say sprintf '%6d: %15d = %s', ++$c, $n, join ' . ', map { "$_->[0]^$_->[1]" } @f
    if 1 == gcd map { $_->[1] < 2 ? next : $_->[1] } @f = factor_exp $n;
}
```

The following are the first 50 achilles numbers.
```
     1:              72 = 2^3 . 3^2
     2:             108 = 2^2 . 3^3
     3:             200 = 2^3 . 5^2
     4:             288 = 2^5 . 3^2
     5:             392 = 2^3 . 7^2
     6:             432 = 2^4 . 3^3
     7:             500 = 2^2 . 5^3
     8:             648 = 2^3 . 3^4
     9:             675 = 3^3 . 5^2
    10:             800 = 2^5 . 5^2
    11:             864 = 2^5 . 3^3
    12:             968 = 2^3 . 11^2
    13:             972 = 2^2 . 3^5
    14:            1125 = 3^2 . 5^3
    15:            1152 = 2^7 . 3^2
    16:            1323 = 3^3 . 7^2
    17:            1352 = 2^3 . 13^2
    18:            1372 = 2^2 . 7^3
    19:            1568 = 2^5 . 7^2
    20:            1800 = 2^3 . 3^2 . 5^2
    21:            1944 = 2^3 . 3^5
    22:            2000 = 2^4 . 5^3
    23:            2312 = 2^3 . 17^2
    24:            2592 = 2^5 . 3^4
    25:            2700 = 2^2 . 3^3 . 5^2
    26:            2888 = 2^3 . 19^2
    27:            3087 = 3^2 . 7^3
    28:            3200 = 2^7 . 5^2
    29:            3267 = 3^3 . 11^2
    30:            3456 = 2^7 . 3^3
    31:            3528 = 2^3 . 3^2 . 7^2
    32:            3872 = 2^5 . 11^2
    33:            3888 = 2^4 . 3^5
    34:            4000 = 2^5 . 5^3
    35:            4232 = 2^3 . 23^2
    36:            4500 = 2^2 . 3^2 . 5^3
    37:            4563 = 3^3 . 13^2
    38:            4608 = 2^9 . 3^2
    39:            5000 = 2^3 . 5^4
    40:            5292 = 2^2 . 3^3 . 7^2
    41:            5324 = 2^2 . 11^3
    42:            5400 = 2^3 . 3^3 . 5^2
    43:            5408 = 2^5 . 13^2
    44:            5488 = 2^4 . 7^3
    45:            6075 = 3^5 . 5^2
    46:            6125 = 5^3 . 7^2
    47:            6272 = 2^7 . 7^2
    48:            6728 = 2^3 . 29^2
    49:            6912 = 2^8 . 3^3
    50:            7200 = 2^5 . 3^2 . 5^2
```
### Removing pretty print

If we remove the pretty print this reduces to:

```perl
for( my( $n, $c, $MAX, @f ) = ( 2, 0, @ARGV ? $ARGV[0] : 1e2 ); $c<$MAX; $n++ ) {
  $c++, say $n if 1 == gcd map { $_->[1] < 2 ? next : $_->[1] } @f = factor_exp $n;
}
```

# Note - product vs factor

There is a different method which is to generate a list of numbers for both problems from a list of primes.

For both challenges I looked at this "product" version of the code (generate a list of primes) and multiplying - rather the factor method. This proved to be slower than the loop through all values of `$n` and filter by factoring. Whether this continues for larger values of `$n` I don't know by I know that producing the first 1 million of each number it was slower, and at that point the product methods then started to hit memory problems.

One of the memory issues is the `sort` a list issue - having to keep multiple large lists in memory. There are work arounds (like using a modified merge sort) but again these have their coding overheads.

If I had to roll my own "factor" code it would almost certainly have been a better option - but the `Math::Prime::Util` methods are plenty fast enough.
