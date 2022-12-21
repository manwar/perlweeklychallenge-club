[< Previous 194](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-194/james-smith) |
[Next 196 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-196/james-smith)

# The Weekly Challenge 195

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-195/james-smith

# Task 1 -  Special Integers

***You are given a positive integer, `$n > 0`. Write a script to print the count of all special integers between `1` and `$n`. An integer is special when all of its digits are unique.***

## Solution
This is bread and butter perl. We are looking for the number of numbers without a repeated digit up to and including `n`. It is easy to find a repeated digit with `/(\d).*\1/`. 

Counting them we just use grep and return the scalar value.

```perl
sub special {
  0+grep{!/(\d).*\1/}1..pop
}
```

This method uses `grep` which shouldn't be a problem in most cases unless `$n` gets large. Alternatively we can walk all values, to get the same result without blowing up the memory on the box!
```perl
sub special {
  local $_ = pop, my $t = 0;
  m{(\d).*\1}||$t++, $_-- while $_;
  $t
}
```

# Task 2 - Most Frequent Even

***You are given a list of numbers, `@list`. Write a script to find most frequent even numbers in the list. In case you get more than one even numbers then return the smallest even integer. For all other case, return `-1`.***

## Solution

We have loop through the numbers past in and keep a hash of all the even values along with their counts. We then want to loop through all the elements finding the one with the largest count (and if equal smallest value).

We do this in two loops - loop 1 to find the even numbers and count them - loop 2 to find the largest count (& smallest value)...

```perl
sub mf_even {
  my($m,%f)=(-1);
  $_%2||$f{$_}++ for@_;
  ($f{$_}>$f{$m}||$_<$m&&$f{$_}==$f{$m})&&($m=$_)for keys%f;
}
```
