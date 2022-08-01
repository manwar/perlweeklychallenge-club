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

We know regex's are slow - so we can replace this by a maths formula. Last digit is odd `$v&1` is `1`, tens digit is `($v/10)&1` is `1`.

```perl
sub reversible_maths {
  my $q;
  grep { ($q = ($_+reverse) )&1 && int($q/10)&1 } 10..99;
}
```

The second version is approximately 80% faster... 22 ms vs 40 ms.
