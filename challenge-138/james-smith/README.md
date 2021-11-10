# Perl Weekly Challenge #138

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-138/james-smith/perl

# Task 1 - Workdays

***Write a script to calculate the total number of workdays in the given year. (Monday to Friday)

## Notes

There are either 260, 261, 262 workdays in a calendar year.

* In a normal year there is 261 workdays unless the year both starts and finishes on a weekend (i.e. there are 260 workdays if the year starts on a Saturday or Sunday);
* In a leap year there is only 260 working days if Jan 1st is a Saturday & Dec 31st is a Sunday; 261 if Jan 1st is a Sunday or Dec 31st is a Saturday, 262 otherwise.

## The solution

So we basically need 2 pieces of information given a year?

 * Is it a leap year
 * What is the first day of the year.

We can then use a look up table which stores the number of working days (over 260) for non leap years and for leap years:

|                         | Sun | Mon | Tue | Wed | Thu | Fri | Sat |
| ----------------------- | --: | --: | --: | --: | --: | --: | --: |
| **day no**              |   0 |   1 |   2 |   3 |   4 |   5 |   6 |
| **#days non-leap year** |   0 |   1 |   1 |   1 |   1 |   1 |   0 |
| **#days leap year**     |   1 |   2 |   2 |   2 |   2 |   1 |   0 |

We break this calculation into 3 functions:

 * `work_days` - this does the look up
 * `leap_year` - tests for leap year
 * `zellers_congruence_jan_1` - uses Zeller's congruence to work out first day of the year {works for the Gregorian calendar}

All of which 
```perl
my @EXTRA_WORKDAYS = ( [0,1,1,1,1,1,0], [1,2,2,2,2,1,0] );

sub leap_year {
  $_[0]&3 || (!($_[0]%100) && $_[0]%400) ? 0 : 1;
}
sub zellers_congruence_jan_1 {
  ( 1 + $_[0]%100 + ($_[0]%100>>2) - ($_[0]/100<<1) + ($_[0]/400>>0) ) % 7;
}

sub work_days {
  260 + $EXTRA_WORKDAYS[ leap_year $_[0] ][ zellers_congruence_jan_1 $_[0] - 1 ];
}

```

# Task 2 - Split Number

***You are given a perfect square, Write a script to figure out if the square root the given number is same as sum of 2 or more splits of the given number.***

## Solution

We use recursion to simplify the problem - first we note that for the sqrt to be the sum of splits of the number then there are always 2 sums except in two trivial cases 0 & 1 (`n^2 = n`) so we can check this in the first wrapper function.

As the first stage in the loop requires some "setup" - we write a wrapper function that:

 * Checks for the edge case of 0/1;
 * Passes in the square root of `$n` as the total we need to compare against in the more generic `split_no` function which works out if there is a way of summing groups of digits.

`split_no` does all the hard work.

It takes 2 parameters - the sum required add a string of digits. We call the function recursively

 * If the the string of digits is empty we have reached the end - and check to see if the remaining sum is zero.
 * If sum is less than 0 then we return 0 - no match.
 * If not we split the string into 2 pieces in all ways possible and call the function.
   * We reduce the sum required by the first part of the string;
   * And pass the second part of the string as the string of digits.

```perl
sub check_square {
  return $_[0] <= 1 ? 0 : split_no( sqrt($_[0]), $_[0] );
}

sub split_no {
  my( $sum, $str ) = @_;
  return 0 if $sum < 0;
  return 0 if $str eq '' && $sum;
  return 1 if $str eq '';
  return 1 if grep { split_no( ($sum - substr $str,$_) , substr $str, 0, $_ ) }
              0 .. -1 + length $str;
  return 0;
}

```
