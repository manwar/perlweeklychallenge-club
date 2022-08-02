[< Previous 175](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-175/james-smith) |
[Next 177 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-177/james-smith)

# The Weekly Challenge 176

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-176/james-smith

# Task 1 - Permuted Multiples

***Write a script to find the smallest integer x such that x, 2x, 3x, 4x, 5x and 6x are permuted multiples of each other. For example, the integers 125874 and 251748 are permutated multiples of each other as 251784 = 2 x 125874 and also both have the same digits but in different order.***

## Solution

We simply loop through all possible solutions.

We start at 123,456 - the number has to have 6 digits which are all different - and this is the lowest number we can try....

We sort the digits for the number (and store in `$z`). We then repeat for each multiple 2 to 6 and compare. We we short cut if we don't find a match.
If all our the same we jump out of the loop and display the value.

```perl
my $t = 123_455;

O: while( my $z = join '', sort split //, ++$t ) {
  ( $z eq join '', sort split //, $_*$t ) || next O for 2..6;
  last;
}

say $t;
```

If we were worried that there were no answers then we coould add a limit to the while statement that checks to see if `$t` is less than or equal to 166,666. The largest value of `$t` for which `6*$t` has 9 digits.

***Bonus*** for noting 142857 is a number any high-school mathematician will recognise - it is the repeating part of `1/7 = 0.142857142857...`

This leads us to the observation that the following integers work {with leading 0}.

| Number                                | Length | repeat unit of | Number without leading zero that works for 6 |
| ------------------------------------: | -----: | -------------: | -------------------------------------------: |
|                 0,588,235,294,117,647 | 16     | 1/17           |                        1,176,470,588,235,294 |
|               052,631,578,947,368,421 | 18     | 1/19           |                      105,263,157,894,736,842 |
|                                       |        |                |                      157,894,736,842,105,263 |
|         0,434,782,608,695,652,173,913 | 22     | 1/23           |                1,304,347,826,086,956,521,739 |
| 0,344,827,586,206,896,551,724,137,931 | 28     | 1/29           |        1,034,482,758,620,689,655,172,413,793 |
|                                       |        |                |        1,379,310,344,827,586,206,896,551,724 |

This works for any prime `$p` for which the repeating sequence has size `$p-1`. Now if we go back to **Challenge 139 - Task 2 - Long Primes** we just worked these out. So we have a quick way to find solutions {not guaranteeing there are no others}...

The first 100 long primes are:
```
7 17 19 23 29 47 59 61 97 109 113 131 149 167 179 181 193 223 229 233 257 263
269 313 337 367 379 383 389 419 433 461 487 491 499 503 509 541 571 577 593 619
647 659 701 709 727 743 811 821 823 857 863 887 937 941 953 971 977 983 1019 1021
1033 1051 1063 1069 1087 1091 1097 1103 1109 1153 1171 1181 1193 1217 1223 1229
1259 1291 1297 1301 1303 1327 1367 1381 1429 1433 1447 1487 1531 1543 1549 1553
1567 1571 1579 1583 1607 1619
```

So that will generate you enough solutions of increasing size

### Performance

Testing on my usual test box comes back in around 0.045 seconds for the loop.

# Task 2 - Reversible Numbers

***Write a script to find out all Reversible Numbers below 100. A number is said to be a reversible if sum of the number and its reverse had only odd digits.***

## Solution

This is a lot faster than the task 1 - but lets see if we can get any improvement (from knowing we are only working with 2 digit numbers).

 * We know that the number cannot have 1 digit as the sum and reverse is always even.
 * If the sum is greater than 100 it is also less than 200, so we can ignore the 100s digit.

So we start with reverse and a regular-expression - the "obvious solution"

```perl
sub reversible_regex {
  grep { ($_+reverse) =~ m{^[13579]{2}$} } 10..99;
}
```

We know regex's are slow - so we can replace this by a maths formula. Last digit is odd `$v%2` is `1`, tens digit is `($v/10)%2` is `1`. Interestingly you would expect `& 1` to be quicker - but it isn't I'm guessing that is because `%` is only an integer operation where `&` can work on numbers and/or strings.

```perl
sub reversible_maths {
  my $q;
  grep { ($q = ($_+reverse) )%2 && int($q/10)%2 } 10..99;
}
```

The second version is approximately 80% faster... 23 ms vs 40 ms. In the scale of things this is not a huge difference - but if this or similar calculations are repeated again and again then that time can build up in the execution of the code.
