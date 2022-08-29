[< Previous 179](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-179/james-smith) |
[Next 181 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-181/james-smith)

# The Weekly Challenge 180

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-180/james-smith

# Task 1 - First Unique Character

***You are given a string, `$s`.  Write a script to find out the first unique character in the given string and print its index (0-based).***

## Solution

We could loop forward through the loop - but that would require us to remember if we had already seen each letter - and then once we have a unique list of letters working out which was first. Alternatively we could `reverse` the problem quite literally and work backwards through the list. The position then being the last unique character that we see. This greatly reduces the complexity.

We loop backwards from the end of the string (`$#p` is the last index of the array). We keep a hash of the letters we have seen `%seen`. We update the count using `++` so the value *returned* is the previous value of the count. If this is zero (*i.e.* the first time we see the character) we update `$last` - to indicate this is the last seen index (working backwards).... The value of `$last` when we get to the end of the loop is therefore the **first** seen value going forward.... I hope the backwards logic makes sense.

```perl
sub first_unique {
  my( @p, $last, %seen ) = split //, pop;
  ( $seen{ $p[$_] } ++ ) || ( $last = $_ ) for reverse 0 .. $#p;
  $last;
}
```

# Task 2 - Trim list

***You are given list of numbers, `@n` and an integer `$i`.  Write a script to trim the given list where element is less than or equal to the given integer.***

## Solution

This is a simple `grep` where we preserve values greater than `$i`. Our function takes to parameters - the first `$i` the filter value, and the second `$n` a reference to the list of numbers to filter.

```perl
sub filter {
  grep { $_ > $_[0] } @{$_[1]};
}
```
