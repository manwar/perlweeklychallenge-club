# Perl Weekly Challenge #137

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-137/james-smith/perl

# Task 1 -  Long year

***Write a script to find all the years between 1900 and 2100 which is a Long Year.***

*Long years are those years with 53 weeks, they either start on a Thursday OR on a Wednesday in a Leap Year*

## The solution

We will do this without using Perl modules or date functions, the only "input" we need is that January 1st 1900 was in fact a Monday.
We encode days of the week with Sunday = 0, Monday = 1, *etc*.

For each year the first thing we have to find out if the year is infact a leap year. That is achieved with the formulae

```perl
! $year % 4 && ( $year % 100 || ! $year % 400 );
```

We then check to see if the year is a long year, *i.e.* if starts on a Thursday (day 4) or Wednesday (day 3) in a leap year

```perl
$start_day == 4 || $start_day == 3 && $is_leap_year;
```

Finally we increment the start day - by two days in a leap year or one in a non-leap year.
```perl
$start_day = ( $start_day + 1 + $is_leap_year ) % 7;
```

Bringing this altogether gives us the following code:

```perl
my $start_day = 1;

foreach my $year ( 1900 .. 2100 ) {
  my $is_leap_year = ! $year % 4 && ( $year % 100 || ! $year % 400 );
  say $year if $start_day == 4 || $start_day == 3 && $is_leap_year;
  $start_day = ( $start_day + 1 + $is_leap_year ) % 7;
}
```

# Task 2 - Lychrel Number

***You are given a number, `10 <= $n <= 1000`. Write a script to find out if the given number is Lychrel number.***
 
*To keep the task simple, we impose the following rules: a. Stop if the number of iterations reached 500; b. Stop if you end up with number >= 10_000_000.*

*Note we don't know which numbers are Lychrel numbers, but we do know which aren't! Brute force will only get us so far - but leaves open the question of a palindrome further down the line than we stop computing and reversing sums.*

## Solution

The solution is suprisingly simple. Check to see if the number is a palindrome - if so return 0. If not add the reverse of the number to itself and repeat until the count or size limits in the question apply.

```perl
sub lychrel {
  my($n,$c) = (shift,$COUNT);
  ($n eq reverse $n) ? (return 0) : ($n+= reverse $n) while $c-- && $n <= $MAX;
  1;
}
```

You will note there is a limit on the size of `$n` in the question, and one of the reasons for this is that when `$n` gets large Perl reverts to floating point representation and the code here fails. Instead we can replace our representation of `$n` as a digit array, we can do the same calculations and checks on the elements of the array, but this allows us to deal with arbitrary sized values.
 
```perl
sub lychrel_large {
  my ( $c, @n ) = ( $COUNT, split //, $_[0] );
  while( $c-- ) {
    return 0 if (join '', my @r = reverse @n ) eq (join '', @n);
    ( $n[$_] += $r[$_] ) > 9  && ($n[$_] -= 10, $_ ? ($n[$_-1]++) : (unshift @n, 1) ) for reverse 0 .. @n-1;
  }
  1;
}
```
The interesting line I suppose is:
```
( $n[$_] += $r[$_] ) > 9  && ($n[$_] -= 10, $_ ? ($n[$_-1]++) : (unshift @n, 1) ) for reverse 0 .. @n-1;
```
This adds the reverse of the number represented in `@n` to itself, ready for the next iteration. If `$n[] = $r[]` is greater than 9 we have to carry one to the left.

If this is not the first digit on `@n` we just carry to the next column `$n[$_-1]`, but if it is the first digit we can't do this so need to add an additional element (containing 1) as the new first digit....

Doing this removes a number of "non Lychrel" numbers that are calculated by the previous function.

### Lychrel numbers computed

The first method found the following candidate Lychrel numbers between 1 and 1000:

89 98 177 187 **196** 276 286 **295** 375 385 **394** **493** 573 583 **592** 672 682 **689** **691** 739 771 781 **788** **790** 849 869 870 **879** 880 **887** 899 937 948 968 **978** **986** 998

The ones highlighted in bold are the candidate Lychrel numbers which are not ruled out by the second function.
