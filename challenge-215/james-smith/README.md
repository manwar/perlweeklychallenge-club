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

We note that if the words are less than 3 characters long then they will be default in alphabetical order so we return 0.

Looping through the letters - we start by getting the signum of the difference between the first two letters (and store in `$f`). We then loop through the remaining letters comparing letter by letter.

 * If the letters are the same we do nothing;
 * If the first two letter are different then we update the update the value of `$f` with the difference between the letter
 * If we find that `$f` has a different signum then wer add 1 to the count and jump to the end of the loop

```perl
sub non_alpha {
  my $c = 0;
  return 0 if length $_[0] <3;
  for(@_) {
    my($f,$s,@rest)=split//;
    $f = $f cmp $s;
    ($s ne $_) && ($f ||= $s cmp $_) != ($s cmp $_) ? ($c++,last)
                                                    : ($s=$_)
      for @rest;
  }
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
