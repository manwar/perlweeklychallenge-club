[< Previous 147](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-145/james-smith) |
[Next 149 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-149/james-smith)
# Perl Weekly Challenge #147

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-148/james-smith

# Challenge 1 - Eban Numbers

***Write a script to generate all Eban Numbers <= 100. An Eban number is a number that has no letter ‘e’ in it when the number is spelled in English (American or British).***

## The solution

```perl
```

### Notes:

# Challenge 2 - Cardano Triplets
***Write a script to generate first 5 Cardano Triplets. A triplet of positive integers (a,b,c) is called a Cardano Triplet if it satisfies the below condition.***

*(a+b.sqrt(c))^(1/3) + (a-b.sqrt(c))^(1/3) = 1*

## The solution

There is a very naive solution which tries all combinations of *a*,*b*,*c*. But there is a more performant solution.

You can rewrite the equation in the form:

*8.a^3 + 15.a^2 + 6.a - 27.b^2.c = 1*

Which can be further parametrized as:

*b^2.c = k^2 . (8.k-3)*

Where *a=3.k-1* *k* starts at 1.

So the first entry *k=1*, *b^2.c=5* - so is solved by *a=2*, *b=1*, *c=5*.

So the code to find all cardano triplets with *a<10,000* is:

```perl
for my $k (1..3333) {
  for( my ($b, $n) = (1, $k*$k*(8*$k-3) ); $n > $b*$b; $b++ ) {
    say join "\t", 3*$k-1, $b, $n/$b/$b unless $n%($b*$b);
  }
}

We loop through each value of `$k` up to 3,333, this gives the maximum value of `$a` 9,998. Largest less than or equal to 10,000.
We then loop `$b` from 1 up to the value where `$c < 1`. Rather than computing `$c` at this stage (there could be rounding errors).
We just compare the numerator (*k^2 . (8.k-3)*) with the denominator (*b^2*). We then check to see `$c` is an integer - we again
do this without computing `$c` to avoid rounding errors - to compute the results and display them.

Time taken to caluclate these **32,235** cardano triplets is **78.5sec**.

```
### The result

