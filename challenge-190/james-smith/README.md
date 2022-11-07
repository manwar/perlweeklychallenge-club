[< Previous 188](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-188/james-smith) |
[Next 190 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-190/james-smith)

# The Weekly Challenge 189

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-189/james-smith

# Task 1 - Greater Character

***You are given an array of characters (a..z) and a target character.  Write a script to find out the smallest character in the given array lexicographically greater than the target character.***


## Solution

This is relatively simple - if the letter matches the requirement that it is bigger than the test value, we just keep track of the lowest value, if it is less than this we set that as the best solution and continue:

```perl
sub greater_char {
  my $best;
  $_ gt $_[1] && !( defined $best && $_ ge $best ) && ($best=$_) for @{$_[0]};
  return $best || $_[1];
}
```

# Task 2 - Array Degree

***You are given an array of 2 or more non-negative integers.  Write a script to find out the smallest slice, i.e. contiguous subarray of the original array, having the degree of the given array.  The degree of an array is the maximum frequency of an element in the array.***

## Solution

We first define the "score" function `sc` which works out the degree of teh array.

We then loop through all contigous array splice (this has size `$n x ($n-1)`) looking for the smallets with the same score.

```perl
sub sc {
  my($v,%f)=0;
  $f{$_}++ for @_;
  ($_>$v)&&($v=$_) for values %f;
  $v
}

sub array_degree {
  my( $start, $end, $target ) = ( 0, $#_, sc( @_ ) );
  for my $st ( 0 .. @_ - $target + 1 ) {
    for ( $st + $target - 1 .. $#_ ) {
      last if     $_ - $st > $end - $start;
      next unless sc( @_[ $st .. $_ ] ) == $target;
      $start=$st, $end=$_;
      last;
    }
  }
  @_[$start..$end];
}
```

## Solution 2 - an improvement.

The nested loop makes the above problem `O(n^2)`. The question is "Can we make it `O(n)`?". Fortunately the answer to that is **YES**.

Firstly we note that for any array. The shortest length sub-slice which contains the most of one particular number will always start
and end with the same digit! This gives us a way in to the `O(n)` solution.

As we loop through the elemens - we don't just store the count of time seen, but the location of the first occurance and the location
of the last. (the first for loop)

Now to find the shortest best solution we loop through the values of this array.

If the frequency _(first value)_ is greater than the best solution so far we replace the best value.

If the frequency is the same, and the length _( third value - second value + 1 )_ is less then we also update the best value. Note in the code we don't include the + 1 - as it appears on both sides so we cancel it out.

Finally we as above return the slice from start to end...

```perl
sub array_degree_linear {
  my($c,%f)=0;

  ( $f{$_} = $f{$_} ? [ $f{$_}[0]+1 , $f{$_}[1], $c ] : [ 1, $c, $c ] ), $c++ for @_;

  my( $best, @rest ) = values %f;

  for( @rest ) {
    $best = $_ if $_->[0] > $best->[0]
               || $best->[0] == $_->[0]
                  && $_->[2]-$_->[1] < $best->[2] - $best->[1];
  }

  @_[ $best->[1]..$best->[2] ]
}
```

## Performance

Testing on the test arrays, even when `n` is in the 3-5 range the second solution is approxmately 2.7 times faster than the naive solution.

If we include the array `[1,2,3,...,99,100,100,99,...,3,2,1]` in our testing we can immediately see the issue with the first code and performance. In this case the naive solution has a rate of about `20` - `25` per second, where the latter `O(n)` solution can execute approximately `8000` - `8500`, this gives of betwween `350x` and `400x`.
