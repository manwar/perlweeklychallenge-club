# Perl Weekly Challenge #143

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-143/james-smith/perl

# Challenge 1 - Calculator

***You are given a string, `$s`, containing mathematical expression. Write a script to print the result of the mathematical expression. To keep it simple, please only accept `+ - * ()`.***`

## The solution

```perl
sub evaluate  {
  my $str = shift;
  1 while $str =~ s/\(\s*([^()]*?)\s*\)/       evaluate($1)             /e;
  1 while $str =~ s/(-?\d+)\s*\*\s*(-?\d+)/    $1 * $2                  /e;
  1 while $str =~ s/(-?\d+)\s*([-+])\s*(-?\d+)/$2 eq '+' ? $1+$3 : $1-$3/e;
  return $str;
}
```

# Challenge 2 - Stealthy Number

***You are given a positive number, `$n`.  Write a script to find out if the given number is Stealthy Number. A positive integer `N` is stealthy, if there exist positive integers `a`, `b`, `c`, `d` such that `a * b = c * d = N` and `a + b = c + d + 1`.***

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

