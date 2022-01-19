[< Previous 141](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-141/james-smith) |
[Next 143 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-143/james-smith)
# Perl Weekly Challenge #142

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-142/james-smith/perl

# Challenge 1 - Divisor Last Digit

***You are given positive integers, `$m` and `$n`.  Write a script to find total count of divisors of `$m` having last digit `$n`.***

## The solution

```perl
sub divisor_last_digit {
  my($m,$n)=@_;
  ($n==1?1:0)+grep{$_%10==$n}
              map{$m%$_?():$m==$_*$_?($_):($_,$m/$_)}
              2..sqrt$m;
}
```

 * First we find all the factors - by looping over all values between `2` and the square root of `$m`. If the value is a factor, so is `$m/$_`.
 * We have a special case when `$m` is a square to avoid including the square root twice.
 * We then `grep` to obtain those which have the correct last digit.
 * There is one extra special case if `$n` is `1` we have to add `1` as `1` is a factor which we miss out in our calculations (so we don't
   equally get `$m` as a factor).

# Challenge 2 - Sleep sort

***Another joke sort similar to JortSort suggested by champion Adam Russell. You are given a list of numbers. Write a script to implement Sleep Sort.***

To perform a sleep sort - we loop through the list of numbers, sleeping for `$value` seconds and updating the list of results with `$value`

## The solution

We need to parallelise this process

There are different ways of doing this `fork`, `threads`, `Promises`.

We will go for the `threads` approach as it easier to implement that `Promises` but doesn't eat at memory by forking lots of times.

```perl
use threads;
use threads::shared;
use Time::HiRes qw(sleep);

my @res :shared;
my @list=map{0.001*int rand 3000}1..20;

say "@list";

sub sleeper {sleep$_[0];push@res,$_[0]}

threads->new( \&sleeper, $_ ) for @list;

$_->join for threads->list;

say for @res;
```

## Notes

 * We create a test set of 20 values between `0` and `3`.
 * We fire off all the threads (`threads->new`)
 * Wait for them to finish `$_->join for threads->list`
 * Return the results.
 * As well as `use threads`, we also `use threads::shared`. This lets us declare the results array `@res` shareable across all processes, which we need to collect the values.

## Caveat

Not all threads start at the same time so sometimes results don't quite come back in the same order - especially if values are close together.

