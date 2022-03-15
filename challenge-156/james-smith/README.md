[< Previous 155](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-155/james-smith) |
[Next 157 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-157/james-smith)
# The Weekly Challenge #156

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-156/james-smith

# Challenge 1 - Pernicious Numbers

***Write a script to permute first 10 Pernicious Numbers. - A pernicious number is a positive integer which has prime number of ones in its binary representation.***

## The solution

First of all we note that we don't need that large a number of primes - for values up to 1,000 we only need 2, 3, 5 & 7; for values up to 1 million 2, 3, 5, 7, 11, 13, 17 & 19. So we therefore hard code our list of primes.

Counting the number of `1`s in the binary representation of the number is as simple as `spintf` the number in binary (`%b`) and then countins the `1s` with `tr/1/1/`.

We use the `redo` trick of last week to get the first `$N` or in this case first `10` - we restart the loop each time we fail to find a perminicious number without moving the the next entry in the array.

```perl
my %p = map { $_ => 1 } 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37;

my $n=0;

$n++, exists $p{(sprintf '%b', $n)=~tr/1/1/} ? (say $n) : redo for 1..10;
```

Expanding out the `for` loop we have the slightly more readable code:

```perl
my %p = map { $_ => 1 } 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37;
my $n = 0;
for (1..10) {
  $n++;
  redo unless exists $p{(sprintf '%b', $n)=~tr/1/1/};
  say $n;
}
```

# Challenge 2 - Weird numbers

***You are given number, $n > 0. Write a script to find out if the given number is a Weird Number - a number for which the sum of the proper divisors (divisors including 1 but not itself) of the number is greater than the number, but no subset of those divisors sums to the number itself.***

## The solution

Our function `is_weird` can be split into 3 parts:

 * Get the proper factors and their sum of the proper factors and check to see if the first condition is not true - return `0`.
 * For every combination of factors see if their sum is `$n` - if true for any combination we return `0` as not weird.
 * Return `1` as the number is weird.

```perl
sub is_weird {
  my($s,$n) = (0,shift);

  $s+=$_ for my @fact = (1,map { $n%$_ ? () : ( $_, $_*$_==$n ? () : $n/$_ ) } 2..sqrt($n));

  return 0 if $s <= $n;

  for my $ind ( 0..(1<<@fact)-1 ) {
    my $t = -$n;
    $ind ? ($ind & 1 && ($t+=$fact[$_]) ) : last, $ind>>=1 for 0..$#fact;
    return 0 unless $t;
  }

  return 1;             ## Weird
}
```

**Notes:**

 * If we push both `$_` and `$n/$_` if `$_` is a factor - we have to check to see that `$n/$_` is not `$_` or `$_*$_ != $n`.
 * With `map` - to remove the entry the block needs to *return* an empty array rather than a `undef` value.
 * In part two we use the bit shift operators twice. Once when getting the number of combinations which is `2^#factors` which can be re-written as `1<<#factors`. We also use it to division by 2 (throwing away remainder) inside the inner loop.
 * Once index `$ind` is 0 we can exit the loop early to avoid unnecessary calculations - reduces the processing time by about 20%. This is achieved by the: `$ind ? ... : last` phrase
 * We can use "`,`" to stitch multiple simple commands together in a postfix `for` loop. *Not always a good thing - but in tight inner code can make the "structure" of the overall code easier to read.

***Note:***

 * That last comment may be a bit frivolous - but sometimes if you expand out the inner of a loop too much you cannot see the whole of the code - and so you lose the "macro"-picture for the "micro"-picture. Someone who is looking at the code than has less idea of what is actually going on overall! You can for-instance take it for granted that the code copes the sum of each combination of factors - and then see what the overall code does with this information!
