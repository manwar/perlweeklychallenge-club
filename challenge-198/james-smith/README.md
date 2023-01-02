[< Previous 197](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-197/james-smith) |
[Next 199 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-199/james-smith)

# The Weekly Challenge 198

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-198/james-smith

# Task 1 - Max Gap

***You are given a list of integers, `@list`. Write a script to find the total pairs in the sorted list where 2 consecutive elements has the max gap. If the list contains less then 2 elements then return 0.***

## Solution

I will present two solutions to this problem. They both start the same way - by first sorting the numbers.

### Method 1 - `max_gap_sort`

This computes the difference between each pair, and then sorts these into order (reverse)
and counts the number of entries who have the same **max** value as the first element of the sorted list...

```perl
sub max_gap_sort {
  return 0 unless $#_;
  @_ = sort { $a <=> $b } @_;
  my $p = shift;
  @_ = sort { $b <=> $a } map { ($_-$p,$p=$_)[0] } @_;
  $_[0]==$_[$_] || return $_ for 1..$#_;
  1*@_
}
```

### Method 2 - `max_gap_nosort`

This computes the difference of each pair and if it is the highest value updates a counter...

**Notes:** If the new value of the difference is greater than the current best value - we update the current best value and
reset the count to 1. We do this in the for loop with a ternary `?:` and then using `&&` to replace another if or `?:` with
an empty second value. Finally we update `$p`. We can separate variables etc within the for loop by replacing `;` for `,` in
a lot of cases...

```perl
sub max_gap_nosort {
  return 0 unless $#_;
  @_ = sort { $a <=> $b } @_;
  my($p,$b,$c)=(shift,0,0);
  $_-$p>$b ? ($b,$c)=($_-$p,1) : $_-$p==$b && $c++, $p=$_ for @_;
  $c
}
```

### Bonus Method 3 - `max_gap_nosort_faster`

One issue with method 2 is that it has to store the sorted list back into @_ AND then loop through it - as we have to get the first value of `$p`...
Now - what if we didn't need to! This would save that store....

Well we can avoid that (in a way) but it is hacky... We set `$p` the be one more than first value in the input! This means that the first gap is always going to be negative so it will only occur once, which as we we aren't interested in the "size" of the gap only the number with the biggest gap we can will always get the right answer...

```perl
sub max_gap_nosort_faster {
  return 0 unless $#_;
  my($p,$t,$c) = ($_[0]+1,0,0);
  $_-$p>$t ? ($t,$c)=($_-$p,1) : $_-$p==$t && $c++, $p=$_ for sort { $a<=>$b } @_;
  $c;
}
```

### Performance

We can see the relative performance of each method {the timing is based on various lists including a list of 1,000,000 numbers}

|               |    Rate  | sort | slide | nosort | nosort_faster |
| :------------ | -------: | ---: | ----: | -----: | ------------: |
| sort          |  0.772/s |   -- |  -31% |   -52% |          -56% |
| slide         |   1.11/s |  44% |    -- |   -30% |          -37% |
| nosort        |   1.59/s | 106% |   43% |     -- |           -9% |
| nosort_faster |   1.75/s | 127% |   58% |    10% |            -- |

The gain between `nosort` & `nosort_faster` is not "visible" in cases wheren the length of list is up to around `100,000` the overhead of the "hack" vs the overhead of storing the intermediate array....

Using List::MoreUtils `slide` has a roughly 30% hit on performance - this again is the effect of having to store relatively large intermediate arrays.

# Task 2 - Prime Count

***You are given an integer `$n > 0`. Write a script to print the count of primes less than `$n`.***

## Solution

Now this is going back sometime since we have a had a prime generator question. We could use `Math::Prime::Util` to get the number of primes with `prime_count` but that sort of defeats the issue here...

We will look at a couple of ways of doing this - the first which is "cute" but not particularly efficient, and then another which is very efficient {obv no where near the performance of the `Math::Prime::Util` version.

### Method 1 - "compact"

First we return `0` if `$n` is less than 3 {there are no primes less than 2}. We then initialize the array with the entry 2, and for each number - we look to see it it's prime... Our prime check is in the line:
```perl
  //,(grep{($'%$_)||next}@_),push@_,$_
```
which is quite compact:
  * `//,` - match nothing - `$'` the post-match string is set to the string i.e `$_` from the outer loop.
  * `(grep{$'%$_||next}@_)` - loop through the array of primes, if `$'%$_` is false we check the right-hand side of the or `||` and evaluate it - which skips out of the map and goes to the next number in the outer `for` loop....
  * `,push@_,$_` if we don't hit the `next` we get to this point - the number is prime so push it onto the list....

The full code is:

```perl
sub n_primes_compact {
  return 0if(my$n=shift)<3;
  @_=2;
  //,(grep{$'%$_||next}@_),push@_,$_ for 3..$n-1;
  1*@_
}
```
If we switch `shift` for `pop` & `grep` for `map`.. This comes down to just 85 bytes (if we us a 1 letter function name)
```perl
sub p{return 0if(my$n=pop)<3;@_=2;//,(map{$'%$_||next}@_),push@_,$_ for 3..$n-1;1*@_}
```

### Method 2 - faster!

The previous method is small - but not particularly fast.. There are a few things we can do to speed it up!

 * We only need to try odd numbers (even numbers will not be included)
 * the largest element of the prime array we need to check is the square root of the number we are testing!
   * square roots are expensive!
   * we keep a track of the smallest integer which is greater than or equal the square root of the number. Note we don't ever have to work out the square root. We can just increment the value `$q` by 1 each time `$i` is greater than it's square... the `last` in the tight `last`/`next` line....
 * a number isn't prime if it has a prime factor - this is the `$i%$_?...:nextO` which skips out of the inner `for` and jumps to the start of the next outer `for`.
 * we don't include `2` in the array as we only check odd-numbers, but add `1` at the end to include it in the count... this gains us about `2%` over keeping it in the array.
 
This give us:

```perl
sub n_primes_fast {
  return 0 if (my $n=shift) <3;
  my($q,@p)=2;
  O: for( my $i=3; $i<$n; $i+=2 ) {
    $q++ if $i>$q*$q;
    $i%$_?($_>$q&&last):next O for @p;
    push @p, $i;
  }
  1+@p
}
```
