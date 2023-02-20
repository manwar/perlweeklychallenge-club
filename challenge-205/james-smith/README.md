[< Previous 204](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-204/james-smith) |
[Next 206 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-206/james-smith)

# The Weekly Challenge 205

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-205/james-smith

# Task 1: Third Highest

***You are given an array of integers. Write a script to find out the Third Highest if found otherwise return the maximum.***

***Note the examples suggest we are looking for third highest unique value - so we will solve both solutions***

## Solution

A quick (code wise) solution would be to sort the list `@_` and take the 3rd value or first if the list has length less than 3. But for large lists this would be inefficient. There is a debate here about what the cut off value is and so a simple sort will be quicker for small arrays.

This was pass 1 - which sorts irrespective of uniqueness. But fails test 3.

We start by sorting the first three values, then we proceed to check the next values against the three current values, and insert the new value into the correct place in the list (or do nothing);

```perl
sub third {
  my ($i,$j,$k) = sort { $b <=> $a } splice @_,0,3;
  return $i unless defined $k;
    $_ > $i ? (($i,$j,$k)=($_,$i,$j))
  : $_ > $j ? (($j,$k)=($_,$j))
  : ( $_ > $k ) && ($k=$_) for @_;
  $k;
}
```

Now if we are looking for uniqueness - then the code becomes slighly more complex. If we have the value matching another value we do nothing. Here we can't splice off the first 3 values, instead we have to check for this equality each time. So the code becomes.
Note we could have re-ordered the checks to avoid the two *skips* when checking for equality - but then the code becomes less readable.

```perl
sub third_unique {
  my ($i,$j,$k) = shift;
    $_ > $i                     ? (($i,$j,$k)=($_,$i,$j))
  : $_ == $i                    ? ()
  : !defined $j || $_ > $j      ? (($j,$k)=($_,$j))
  : defined $j && $_ == $j      ? ()
  : ( !defined $k || $_ > $k ) && ($k=$_) for @_;
  $k//$i;
}
```

# Task 2: Maximum XOR

***You are given an array of integers. Write a script to find the highest value obtained by XORing any two distinct members of the array.***

## Solution

There is nothing other than brute force to find the solution as we have to check every combination. Just how we do this - using indexes or `shift` and `for{each}`. We go for the latter and the code becomes simple.

```perl
sub max_xor {
  my $m = 0;
  while( @_ ){
    my $x=shift;
    ( $x^$_ ) > $m && ( $m = $x^$_ ) for @_
  }
  $m
}
```
To avoid a set of brackets we use the simple logic of `$a && $b` is the same as `$b if $a`.
