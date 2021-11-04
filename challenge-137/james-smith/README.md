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

## What is a "long year"?

All years are the same length (except for leap years) so what is a long year.

Every week (starting on a Monday) is allocated a number of the form year-week. Now for 51 (or 52) weeks
of the year that week fall entirely in one year. The first and last week can span two years.

To avoid ambiguity those weeks are allocated to one or other of the years, and so it is allocated to
the year that has the most of its days in, i.e. 4, 5, 6 or 7.

In a normal year there are 8 days in these two weeks (and a leap year 9). So for both the first and last week
to be allocated to the same year they they must have 4 days each in the same year (and 4 & 5 in a leap year).

So long years either start on a Thursday (Thurs -> Sun = 4 days) OR on a Wednesday (Weds -> Sun = 4 days)
in a Leap Year.

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

## What is a Lychrel Number?

To find out if a number is a Lychrel number, we generate a sequence by adding each number to reverse of itself, repeatedly, terminating when the value is a palindrome.

A Lychrel Number is one such that sequence the sequence is infinite. These leads to the fact that we don't know if a number is a Lychrel Number - just that we know it doesn't {in some bases there are numbers for which the sequence forms a pattern and so are known to be Lychrel numbers). Therefore all Lycrhel Numbers are known as candidate Lychrel numbers.

Now we can't go on for an infinite amount of time - so the challenge says *To keep the task simple, we impose the following rules: a. Stop if the number of iterations reached 500; b. Stop if you end up with number >= 10_000_000.* Note you will never reach 500 iterations with the limit of `1e7`. Brute force will only get us so far - but leaves open the question of a palindrome further down the line than we stop computing and reversing sums.

We will later develop a second solution which can rule out more numbers buy removing the restriction on the size of number, and increasing the number of iterations.

## Solution

The solution is suprisingly simple. Check to see if the number is a palindrome - if so return 0. If not add the reverse of the number to itself and repeat until the count or size limits in the question apply. `$COUNT` and `$MAX` are the constants defined above {you can easily experiment by changing the values to see how more/less candidates we find)

```perl
sub lychrel {
  my($n,$c) = (shift,$COUNT);
  ($n eq reverse $n) ? (return 0) : ($n+= reverse $n) while $c-- && $n <= $MAX;
  1;
}
```

## A larger solution

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

## Finding more Lychrel nubmers

This lead me to seeing if I could a longer list of compute Lychrel numbers, this gets slower as the range of numbers being tested gets longer (especially as any candidate Lychrel number takes as many iterations as you allow). But there is a way you can improve performance. It works similar to the sieve of Eratosthenes for prime numbers.

Here is the perl - I will try and explain how it works afterwards.
```perl
my( %seeds, %lychrel );

sub lychrel_large_seed {
  my ( $c, $n, @n ) = ( $COUNT, $_[0], split //, $_[0] );
  while( $c-- ) {
    my @r = reverse @n;
    my $rn = join '', @r;
    my $nn = join '', @n;
    return exists $lychrel{$seeds{$rn}} if $r[0] && defined $seeds{$rn};
    return exists $lychrel{$seeds{$nn}} if          defined $seeds{$nn};
    $seeds{ $rn } = $n if $rn < $S_MAX*$MULT && $r[0];
    $seeds{ $nn } = $n if $nn < $S_MAX*$MULT;
    return 0 if $rn eq $nn; ## Check if palindromic
    ## Add the arrays as if numbers - note this is compact - but does the job!
    ( $n[$_] += $r[$_] ) > 9  && ($n[$_] -= 10, $_ ? ($n[$_-1]++) : (unshift @n, 1) ) for reverse 0 .. @n-1;
  }
  1;
}

foreach my $n (10..$S_MAX) {
  if( defined $seeds{$n} ) {
    $lychrel{$n}++ if exists $lychrel{$seeds{$n}};
    next;
  }
  $lychrel{$n}=1 if lychrel_large_seed($n);
}

say $_ foreach sort { $a <=> $b } keys %lychrel;
```

### Performance

Using this script to generate all candidate Lychrel numbers up to 1 million took approximately `12` seconds. To use the `lychrel_large` routine took approximately 2180 seconds (36 minutes 20 seconds), a speed gain of approximately `180x`.

To 10 million the time taken was approximately 1 min 40s; 20 million ~ 3 min 50s; 30 million ~ 31 min 40s {I think the time for this got large as the machine was starting to hit SWAP storage}. The code fails shortly after this as memory and swap was exhausted ~ 12GB.

| N          | Lychrel < N | Time taken |
| ---------: | ----------: | ---------: |
| 10,000,000 |   2,010,871 |  1 min 40s |
| 20,000,000 |   4,521,930 |  3 min 50s |
| 30,000,000 |   7,177,742 | 31 min 40s |

### Explanation

For every sequence generated above - all the numbers are either not Lychral numbers or candidate Lychral numbers. Once we either get to a palindrome OR reach the "end of the sequence" we can tag every number as either a candidate Lychral number or not. This reduces the number of calculations.

But even more two sequences can converge so that if we find a number we have seen in another sequence we know that all the numbers we have seen are Lychral or not without finding the palindrome / hitting the end of the sequence... Which speeds it up further.

