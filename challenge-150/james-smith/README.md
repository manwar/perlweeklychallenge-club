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
  $n--,say $i if exists $fib{$ds};                      ## 4
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

```perl
sub biggest_perfect_square {
  my $nt = my $m = (my $n = shift) -1;                       ## 1
  $m=$m*$n+$nt while $nt--;                                  ## 2
  O: for( my $t = int sqrt $m; ; $t -- ) {                   ## 3
    my ($q,%seen) = $t**2;                                   ## 4
    $seen{$q%$n}++?(next O):($q=int($q/$n)) while $q;        ## 5
    return $t;                                               ## 6
  }
}
```

**Notes:**

 * Line 1 - initialise `$n` the base we are looking at, and variables to compute the maximum possible square
 * Line 2 - Compute the maximum possible pandigital value for the given base - it is the digits in descending order *e.g.* `BA9876543210` for `$n=12`
 * Line 3 - Here we just loop from the maximum possible square (sqrt of max pandigital number rounded down). Loop will finish for all +be bases as `1` is a solution in all cases.
 * Line 4/5 - We loop through all digits to see if we have already seen the digit if so we skip to the next value of `$t` by using `next` with a label to not just out of this loop but to go to the next element of the outer loop.
 * If we get through the while loop we have a value - and it must be the highest.

## Results

The values for each value of $N are given below up to (base 15) - the largest value for which we can compute in perl's 64-bit architecture.

|  N | v         | v^2                | v^2 (base N)    | Time      | Evals    |
| -: | --------: | -----------------: | --------------: | --------: | -------: |
|  2 |         1 |                  1 |               1 |  0.000020 |        1 |
|  3 |         1 |                  1 |               1 |  0.000022 |        4 |
|  4 |        15 |                225 |            3201 |  0.000014 |        1 |
|  5 |        24 |                576 |            4301 |  0.000043 |       31 |
|  6 |       195 |              38025 |          452013 |  0.000029 |       17 |
|  7 |       867 |             751689 |         6250341 |  0.000045 |       28 |
|  8 |      3213 |           10323369 |        47302651 |  0.001050 |      841 |
|  9 |     18858 |          355624164 |       823146570 |  0.000947 |      671 |
| 10 |     99066 |         9814072356 |      9814072356 |  0.000476 |      315 |
| 11 |    528905 |       279740499025 |     A8701245369 |  0.004091 |     2564 |
| 12 |   2950717 |      8706730814089 |    B8750A649321 |  0.035980 |    22903 |
| 13 |   4809627 |     23132511879129 |    CBA504216873 | 18.936489 | 12533147 |
| 14 | 105011842 |  11027486960232964 |  DC71B30685A924 |  0.143197 |    89326 |
| 15 | 659854601 | 435408094460869201 | EDAC93B24658701 |  0.315265 |   190654 |


You will note that most time is taken where `$n` is 13. You will note that for `$n` in `2`, `3`, `5`, `13` there are no pan-digital solutions so we have to loop through all the 13 digit numbers and reach the 12 digit numbers before we find a solution. **97.6%** of the checks for matching digits are in the case where `$n` is 13 (approximately **97%** of the time in the code).

