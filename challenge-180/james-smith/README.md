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

The first stage of this is to count the instances of each letter - here we use `List::MoreUtils`'s method `frequency` - this just loops over each character and increments the count.

We then want to *grep* over the array and find the first character who has a count less than 2 and return the index. We could write this long-hand but `List::MoreUtils` has the perfect *helper* here `firstidx` which does just that. So the code becomes. Note although not in the *spec* this returns `-1` if there are no unique letters.

```perl
sub first_unique {
  my %counts = frequency my @p = split //, pop;
  firstidx { $counts{$_} < 2 } @p;
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
