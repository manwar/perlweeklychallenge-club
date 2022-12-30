[< Previous 196](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-196/james-smith) |
[Next 198 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-198/james-smith)

# The Weekly Challenge 197

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-196/james-smith

# Task 1 - Move Zero

***You are given a list of integers, `@list`. Write a script to move all zero, if exists, to the end while maintaining the relative order of non-zero elements.***

## Solution
I looked at a number of solutions for this - but it turns out that perl grep seems to be the best...

```perl
sub move_zero{
  grep({$_}@_),grep{!$_}@_
}
```
Using `$_` and `!$_` to pull the lists apart. Anything more complex in the grep slows it down more than you lose by doing the second `grep`.

# Task 2 - Wiggle sort

***You are given a list of integers, `@list`. Write a script to perform Wiggle Sort on the given list. Wiggle sort would be such as:***

```
list[0] < list[1] > list[2] < list[3]…
```

## Solution

OK if we relax the condition with `<=`/`=>` rather than `<`/`>` we can always come up with a solution. The simplest way to do this is to split the list in two (using `splice` and then stitching them back together. (If it has an odd length we keep the first list as the longest!)

```perl
sub ws_lax {
  return @_ if @_<2; ## Always works if 0/1 element.
  my@q=splice @_,0,$#_/2+1;
  map{$_,@_?shift:()}@q
}
```

If we wish to perform the strict version we have to test conditions for which there are no solution...

 * If we have more than half (if even length) or *half + 1* (if odd) of the lowest digit we have no solution.
 * o/w if we have exactly half (if even length) or *half + 1* (if odd) of the lowest digit we have a solution.
 * o/w if we have more than half (if even length) or *half - 1* (if odd) of the highest digit we have no solution
 * o/w if we have exactly than half (if even length) or *half - 1* (if odd) of the highest digit we have no solution
 * o/w if we have half or more (if even length) or *half - 1* or more (if odd) of any other digit we have no solution
 * o/w we have a solution

This leads us to:

```perl
sub _ws {
## Does wiggle sort by splicing and interleaving sorted list...
  my@q=splice @_,0,$#_/2+1;map{$_,@_?shift:()}@q
}

sub ws_strict {
## Return "wiggle sorted list" or error message indicating if
## the problem number is the first number, last number or one
## of the other numbers...

  return @_ if @_<2;
  @_=sort{$a<=>$b} @_;
  return $_[0]  == $_[$#_/2+1] ?                 'Bottom' # We can't have more than ceil(n/2) of the first number
       : $_[0]  == $_[$#_/2  ] ?                 _ws(@_)  # But we can have ceil(n/2) of the first number
       : $_[-1] == $_[$#_/2  ] ?                 'Top'    # We can't have more than floor(n/2) of the last number
       : $_[-1] == $_[$#_/2+1] ?                 _ws(@_)  # But we can have floor(n/2) of it
       : (grep{$_[$_]==$_[$_+$#_/2]}0..@_/2-1) ? 'Middle' # We can't have equal or more than floor(n/2) of any other number
       :                                         _ws(@_)
       ;
}

sub ws_lax {
## Return "wiggle sorted list" - note we are using the lax <= => check here
  @_<2?@_:_ws(sort{$a<=>$b}@_)
}
```
