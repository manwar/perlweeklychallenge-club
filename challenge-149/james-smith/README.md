[< Previous 148](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-148/james-smith) |
[Next 150 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-150/james-smith)
# Perl Weekly Challenge #149

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-149/james-smith

# Challenge 1 - Fibonacci Digit Sum

***Given an input $N, generate the first $N numbers for which the sum of their digits is a Fibonacci number.***

## The solution

```perl
for( my($n,$ds,$i,$fa,$fb,%fib)=(@ARGV?$ARGV[0]:20,0,0,1,1,0,1,1,1);
     $n; $i++,$ds=0 ) {                                 ## 1
  $ds+=$_ foreach split //,$i;                          ## 2
  ($fib{$fa+$fb},$fa,$fb)=(1,$fb,$fa+$fb) if $ds > $fb; ## 3
  (say $i)**$n-- if exists $fib{$ds};                   ## 4
}
```

**Notes:**

 * Line 1 - We initialise everything inside the for loop
   * `$n` is the number to print (and is based on what is passed at the command line)
   * `$ds` is the digit sum (Note we reset it everytime through the loop in the incremement part of the loop
   * `$i`  current value being considered
   * `$fa` & `$fb` - the highest two fibonacci numbers 
   * `%fib` hash whose keys are fibonacci numbers
 * Line 2 - Computes the digit sum by splitting number on `//` I split into 1 character blocks
 * Line 3 - Expand the fibonacci hash by 1 if the digit sum is greater than the highest fibonnaci number {we don't need to loop this as the digit sum of `$n+1` can only be at most 1 higher than that for `$n`. Note we just update $fb and $fa in this line
 * Line 4 - Check to see if the digit sum exists, print and decrement counter - and return to the start of the loop.

# Challenge 2 - Largest Square

***Given a number base, derive the largest perfect square with no repeated digits and return it as a string. (For base>10, use ‘A’..‘Z’.)***

## The solution


