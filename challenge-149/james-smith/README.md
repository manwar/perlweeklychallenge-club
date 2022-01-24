[< Previous 147](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-145/james-smith) |
[Next 149 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-149/james-smith)
# Perl Weekly Challenge #148

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

I will present two different solutions for the more general problem of large Eban numbers, but for numbers less than 1,000 we have:

* The units must be 0, 2, 4, 6
* The tens must be 0, 30, 40,50, 60, 

So to compute the eban numbers less than 100 (and consequently all eban numbers less than one thousand) we can use:

```perl
say for map{my$a=$_;map{10*$a+2*$_||()}(0..3)}(0,3..6);
```

The `||()` removes the zero value which is not an eban number.

This gives us the following numbers less than 1,000:

`2 4 6 30 32 34 36 40 42 44 46 50 52 54 56 60 62 64 66`

Now we can use this sequence to generate all eban numbers.

For eban numbers of order *1000^n* we just need to multiply all the eban numbers of order "*1000^(n-1)*" these by 1000 and add each one add each of the eban numbers less than 100 (this time including 0). This assumes that for values of 1000, 1000000 etc we say *one thousand*, *one million*, ...

```perl
say for my@e=grep{$_}my@n=map{my$a=$_;map{10*$a+2*$_}(0..3)}(0,3..6);
for(2..$N){
  say for@e=map{my$a=$_;map{$a*1e3+$_}@n}@e;
}
```

The second removes the need to use `sprintf` everytime in the subsequent loops, by generating the list of numbers padded with 0s - we can see this with the performance gain in all but the first case (the first loop is made slightly more complex).

### Notes: Timings

| Max   | (in words)  | Rate            | Count      |
| ----: | :---------: | --------------: | ---------: |
|  10^3 | Thousand    |   200,481.00 /s |         19 |
|  10^6 | Million     |    18,214.94 /s |        399 |
|  10^9 | Billion     |       971.82 /s |      7,999 |
| 10^12 | Trillion    |        49.41 /s |    159,999 |
| 10^15 | Quadrillion |         2.27 /s |  3,199,999 |
| 10^18 | Quintillion |         0.10 /s | 63,999,999 |

Unable to proceed with values of n greater than 6, as we are hitting memory limits, and the size of integer perl can store by default (64-bit).

 * Would need to look at using `bigint` for working with arbitrary sized integers or reverting to a string based solution (although this uses a even more memory)

# Challenge 2 - Cardano Triplets
***Write a script to generate first 5 Cardano Triplets. A triplet of positive integers (a,b,c) is called a Cardano Triplet if it satisfies the below condition.***

*(a+b.sqrt(c))^(1/3) + (a-b.sqrt(c))^(1/3) = 1*

## The solution

There is a very naive solution which tries all combinations of *a*,*b*,*c*. But there is a more performant solution.

You can rewrite the equation in the form:

*8.a^3 + 15.a^2 + 6.a - 27.b^2.c = 1*

Which can be further parametrized as:

*b^2.c = k^2 . (8.k-3)*

Where *a=3.k-1*. and *k* starts at 1.

So the first entry *k=1*, *b^2.c=5* - so is solved by *a=2*, *b=1*, *c=5*.

So the code to find all cardano triplets with *a<10,000* is:

```perl
for my $k (1..3333) {
  for( my ($b, $n) = (1, $k*$k*(8*$k-3) ); $n > $b*$b; $b++ ) {
    say join "\t", 3*$k-1, $b, $n/$b/$b unless $n%($b*$b);
  }
}
```

We loop through each value of `$k` up to 3,333, this gives the maximum value of `$a` 9,998. Largest less than or equal to 10,000.
We then loop `$b` from 1 up to the value where `$c < 1`. Rather than computing `$c` at this stage (there could be rounding errors).
We just compare the numerator (*k^2 . (8.k-3)*) with the denominator (*b^2*). We then check to see `$c` is an integer - we again
do this without computing `$c` to avoid rounding errors - to compute the results and display them.

Time taken to calculate these **32,235** cardano triplets is **78.5sec**.

If we go back to the original problem and look at the first 5 cardano triplets we have either:

The first 5 (if you sort by *a* and *b*) are:

    (2,1,5), (5,1,52), (5,2,13), (8,1,189), (8,3,21).

The first 5 (if you sort by total *a+b+c*) are:

    (2,1,5), (5,2,13), (8,3,21), (17,18,5), (11,4,29).
