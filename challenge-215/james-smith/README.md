[< Previous 214](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-214/james-smith) |
[Next 216 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-216/james-smith)

# The Weekly Challenge 215

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-215/james-smith

# TASK #1: Odd one Out

***You are given a list of words (alphabetic characters only) of same size. Write a script to remove all words not sorted alphabetically and print the number of words in the list that are not alphabetically sorted.***

## Solution

To solve this problem we loop though each string to make sure the letters in alphabetical order.

We note that if the words are 1 character long then they will be default in alphabetical order so we return 0.

Looping through the letters - we just see if one is greater than or equal to the previous one - if it isn't we update the counter and move on to the next word.

Note we use a ternary to replace this `if`/`else` for compactness.

```perl
sub non_alpha {
  return 0 if length $_[0] <2;
  my($c,$f)=0;
  for(@_) {
    $f='';
    $f gt $_ ? ($c++,last) : ($f=$_) for split //;
  }
  $c
}
```

We can compact this by converting the inner `for` into a `map` - note the `last` was on the inner loop - and is the same as a `next` on the outer loop... So here we have to now use `next` not `laat`

```perl
sub non_alpha_compact {
  return 0 if length $_[0] <2;
  my($c,$f)=0;
  $f='', map { $f gt $_ ? ($c++,next) : ($f=$_) } split // for @_;
  $c
}
```

# TASK #2: Number Placement

***You are given a list of numbers having just 0 and 1. You are also given placement count (>=1). Write a script to find out if it is possible to replace 0 with 1 in the given list. The only condition is that you can only replace when there is no 1 on either side. Print 1 if it is possible otherwise 0.***

*Question - there are two intepretations o the question - whether the placements are done simultaneously or one after the other*

*In the former case any run of 3+ zeros can have `n-2` updates, but if it is the former it `(n-1)/2`

## Solution

Both solutions are the same except for the calculation at the heart to compute the count.

We loop through the numbers if we see a 1 we check to see how many previous 0's we've had and compute the number of insertions. If it is 0 we increment the count of 0's in a row. Note to make sure we include any last sequence of 0's we add a 1 on to the end of the list we are search.

```perl
sub insert_zero {
   my($s,$c) = (0,shift);
   $_ ? ( $c-= $s>2 &&  int(($s-1)/2), $s=0 ) : $s++ for @_,1;
   $c>0?0:1;
}

sub insert_zero_simultaneous {
  my($s,$c) = (0,shift);
  $_ ? ( $c-= $s>2 && $s-2, $s=0 ) : $s++ for @_,1;
  $c>0?0:1
}
```

We can get some performance improvements by short cutting the loop, by checking the value of $c at each stage rather than just at the end. This is most important if the number of inserts is relatively low in comparison to the size of the list.

```perl
sub insert_zero_shortcut {
   my($s,$c) = (0,shift);
   $_ ? ( $c-= $s>2 &&  int(($s-1)/2), $s=0, $c>0 || return 1 ) : $s++ for @_,1;
   0;
}

sub insert_zero_simultaneous_shortcut {
  my($s,$c) = (0,shift);
  $_ ? ( $c-= $s>2 && $s-2, $s=0, $c>0 || return 1 ) : $s++ for @_,1;
  0;
}
