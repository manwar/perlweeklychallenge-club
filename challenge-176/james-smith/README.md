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

### Performance

Testing on my usual test box comes back in around 0.045 seconds for the loop.

##Bonus##

We note 142857 is a number any high-school mathematician will recognise - it is the repeating part of `1/7 = 0.142857142857...`

This leads us to the observation that the following integers work {with leading 0}.

| Number                                | Length | repeat unit of | Number without leading zero that works for 6 |
| ------------------------------------: | -----: | -------------: | -------------------------------------------: |
|                 0,588,235,294,117,647 | 16     | 1/17           |                        1,176,470,588,235,294 |
|               052,631,578,947,368,421 | 18     | 1/19           |                      105,263,157,894,736,842 |
|                                       |        |                |                      157,894,736,842,105,263 |
|         0,434,782,608,695,652,173,913 | 22     | 1/23           |                1,304,347,826,086,956,521,739 |
| 0,344,827,586,206,896,551,724,137,931 | 28     | 1/29           |        1,034,482,758,620,689,655,172,413,793 |
|                                       |        |                |        1,379,310,344,827,586,206,896,551,724 |

This works for any prime `$p` for which the repeating sequence has size `$p-1`. Now if we go back to **Challenge 139 - Task 2 - Long Primes** we just worked these out. So we have a quick way to find solutions {not guaranteeing there are no others in between)

We generate these with this code... we have our long prime code for before. But for each long prime we keep the sequence and find any rotation which starts with a "1" and is less that "10/6" or "1666666............." This is in the `map` (rotations) `grep` starts with ` `grep` less than `16666...`. There are roughly "`p/15`" solutions for each value of long prime `p`.

```perl
my($N,$p,@primes) = ($ARGV[0]//20,1);

Z: for ( 1 .. $N ) {
  $p+=2;
  ($p % $_) || (redo Z) for @primes;
  push @primes, $p;
  my( $N, $s ) = ( 1, '' );
  $s .= int( $N/$p ), $N %= $p, $N .= 0 for 0 .. 2 * $p + length $p;
  redo unless $s =~ /(.+?)\1+$/;
  redo if $p - 1 - length $1;
  my( $cr, $th ) = ( $1, '1'.('6' x ($p-2)) );
  say for
    sort
    grep { $th gt $_ }
    grep { '1' eq substr $_,0,1  }
    map  { substr $cr, 0, 0, substr $cr, -1, 1, ''; $cr }
    1 .. $p-1;
}
```

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
