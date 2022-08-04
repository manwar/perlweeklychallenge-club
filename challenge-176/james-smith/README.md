[< Previous 175](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-175/james-smith) |
[Next 177 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-177/james-smith)

# The Weekly Challenge 176

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-176/james-smith

# Task 1 - Permuted Multiples

***Write a script to find the smallest integer x such that x, 2x, 3x, 4x, 5x and 6x are permuted multiples of each other. For example, the integers 125874 and 251748 are permutated multiples of each other as 251784 = 2 x 125874 and also both have the same digits but in different order.***

## Solution

We simply loop through all possible solutions.

We start at 123,456 - the number has to have 6 digits which are all different - and this is the lowest number we can try....

We sort the digits for the number (and store in `$z`). We then repeat for each multiple 2 to 6 and compare. We we short cut if we don't find a match.
If all our the same we jump out of the loop and display the value.

```perl
my $t = 123_455;

O: while( my $z = join '', sort split //, ++$t ) {
  ( $z eq join '', sort split //, $_*$t ) || next O for 2..6;
  last;
}

say $t;
```

If we were worried that there were no answers then we coould add a limit to the while statement that checks to see if `$t` is less than or equal to 166,666. The largest value of `$t` for which `6*$t` has 9 digits.

### Performance

Testing on my usual test box comes back in around 0.045 seconds for the loop.

##Bonus##

We note 142857 is a number any high-school mathematician will recognise - it is the repeating part of `1/7 = 0.142857142857...`

This leads us to the observation that the following integers work {with leading 0}.

| Number                                | Length | repeat unit of | Number without leading zero that works for 6 |
| ------------------------------------: | -----: | -------------: | -------------------------------------------: |
|                 0,588,235,294,117,647 | 16     | 1/17           |                        1,176,470,588,235,294 |
|               052,631,578,947,368,421 | 18     | 1/19           |                      105,263,157,894,736,842 |
|                                       |        |                |                      157,894,736,842,105,263 |
|         0,434,782,608,695,652,173,913 | 22     | 1/23           |                1,304,347,826,086,956,521,739 |
| 0,344,827,586,206,896,551,724,137,931 | 28     | 1/29           |        1,034,482,758,620,689,655,172,413,793 |
|                                       |        |                |        1,379,310,344,827,586,206,896,551,724 |

This works for any prime `$p` for which the repeating sequence has size `$p-1`. Now if we go back to **Challenge 139 - Task 2 - Long Primes** we just worked these out. So we have a quick way to find solutions {not guaranteeing there are no others in between)

We generate these with this code... we have our long prime code for before. But for each long prime we keep the sequence and find any rotation which starts with a "1" and is less that "10/6" or "1666666............." This is in the `map` (rotations) `grep` starts with ` `grep` less than `16666...`. There are roughly "`p/15`" solutions for each value of long prime `p`.

This becomes the code below. If we run this to the 5,000th long prime `144,983`. This generates `22,642,428` solutions to this problem - on the test machine this took about 4 hours 15 minutes. {Output file size is approx 1.95 Tbytes)

```perl
my($N,$p,@primes) = ($ARGV[0]//20,1);

Z: for ( 1 .. $N ) {
  $p+=2;
  ($p % $_) || (redo Z) for @primes;
  push @primes, $p;

  my( $N, $s ) = ( 1, '' );
  $s .= int( $N/$p ), $N %= $p, $N .= 0 for 0 .. 2 * $p + length $p;

  redo unless $s =~ /(.+?)\1+$/;
  redo if     $p - 1 - length $1;

  my( $cr, $th ) = ( $1, '1'.('6' x ($p-2)) );
  say for sort
    map { substr $cr, 0, 0, substr $cr,-1,1,"";
          ( substr $cr,0,1 eq "1" && $cr lt $th ) ? $cr : () }
    1 .. $p-1;
}
```
Timings for this below are:

| Idx   | Prime   | #Sol for p | $Solns cumul | Time for p     | Cumul. time    |
| ----: | ------: | ---------: | -----------: | -------------: | -------------: |
|     1 |       7 |          1 |            1 |    0.00005 sec |      0.000 sec |
|     2 |      17 |          1 |            2 |    0.00010 sec |      0.000 sec |
|     3 |      19 |          2 |            4 |    0.00004 sec |      0.000 sec |
|     4 |      23 |          1 |            5 |    0.00004 sec |      0.000 sec |
|     5 |      29 |          2 |            7 |    0.00005 sec |      0.000 sec |
|     6 |      47 |          3 |           10 |    0.00027 sec |      0.001 sec |
|     7 |      59 |          4 |           14 |    0.00017 sec |      0.001 sec |
|     8 |      61 |          4 |           18 |    0.00010 sec |      0.001 sec |
|     9 |      97 |          7 |           25 |    0.00076 sec |      0.002 sec |
|    10 |     109 |          8 |           33 |    0.00060 sec |      0.002 sec |
|    20 |     233 |         15 |          152 |    0.00048 sec |      0.009 sec |
|    30 |     419 |         28 |          378 |    0.00249 sec |      0.024 sec |
|    40 |     577 |         39 |          716 |    0.00118 sec |      0.044 sec |
|    50 |     821 |         54 |        1,184 |    0.00170 sec |      0.083 sec |
|    60 |     983 |         65 |        1,794 |    0.00198 sec |      0.118 sec |
|    70 |   1,103 |         73 |        2,503 |    0.00244 sec |      0.154 sec |
|    80 |   1,291 |         86 |        3,303 |    0.01057 sec |      0.209 sec |
|    90 |   1,487 |         99 |        4,222 |    0.01812 sec |      0.277 sec |
|   100 |   1,619 |        108 |        5,269 |    0.00859 sec |      0.343 sec |
|   200 |   3,581 |        238 |       22,587 |    0.01193 sec |      1.656 sec |
|   300 |   5,927 |        395 |       54,329 |    0.03394 sec |      4.770 sec |
|   400 |   8,269 |        552 |      101,541 |    0.04372 sec |      9.866 sec |
|   500 |  10,687 |        713 |      165,007 |    0.08683 sec |     17.831 sec |
|   600 |  12,983 |        865 |      243,974 |    0.09910 sec |     28.945 sec |
|   700 |  15,583 |      1,039 |      338,908 |    0.15089 sec |     44.510 sec |
|   800 |  18,217 |      1,215 |      451,180 |    0.18037 sec |     64.866 sec |
|   900 |  21,023 |      1,401 |      582,089 |    0.23900 sec |     91.365 sec |
| 1,000 |  23,669 |      1,578 |      731,816 |    0.28995 sec |    123.847 sec |
| 1,500 |  37,579 |      2,506 |    1,748,190 |    1.58653 sec |   6 min 44 sec |
| 2,000 |  51,419 |      3,428 |    3,236,184 |    1.35020 sec |  15 min 44 sec |
| 2,500 |  66,109 |      4,408 |    5,195,043 |    2.16593 sec |  30 min 46 sec |
| 3,000 |  80,737 |      5,383 |    7,640,222 |    3.25390 sec |  53 min 24 sec |
| 3,500 |  96,353 |      6,423 |   10,595,919 |    4.42871 sec |  80 min 55 sec |
| 4,000 | 112,663 |      7,511 |   14,080,184 |    6.78954 sec | 130 min 39 sec |
| 4,500 | 128,033 |      8,535 |   18,095,741 |    7.56670 sec | 189 min  2 sec |
| 5,000 | 144,983 |      9,665 |   22,642,428 |    9.94132 sec | 263 min 39 sec |

# Task 2 - Reversible Numbers

***Write a script to find out all Reversible Numbers below 100. A number is said to be a reversible if sum of the number and its reverse had only odd digits.***

## Solution

This is a lot faster than the task 1 - but lets see if we can get any improvement (from knowing we are only working with 2 digit numbers).

 * We know that the number cannot have 1 digit as the sum and reverse is always even.
 * If the sum is greater than 100 it is also less than 200, so we can ignore the 100s digit.

So we start with reverse and a regular-expression - the "obvious solution"

```perl
sub reversible_regex {
  grep { ($_+reverse) =~ m{^[13579]{2}$} } 10..99;
}
```

We know regex's are slow - so we can replace this by a maths formula. Last digit is odd `$v%2` is `1`, tens digit is `($v/10)%2` is `1`. Interestingly you would expect `& 1` to be quicker - but it isn't I'm guessing that is because `%` is only an integer operation where `&` can work on numbers and/or strings.

```perl
sub reversible_maths {
  my $q;
  grep { ($q = ($_+reverse) )%2 && int($q/10)%2 } 10..99;
}
```

The second version is approximately 80% faster... 23 ms vs 40 ms. In the scale of things this is not a huge difference - but if this or similar calculations are repeated again and again then that time can build up in the execution of the code.
