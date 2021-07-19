# Perl Weekly Challenge #122

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-122/james-smith/perl

# Task 1 - Average of Stream

***You are given a stream of numbers, `@N`. Write a script to print the average of the stream at every point.***

## The solution

Firstly - we create a "stream object" - we use a single function
`stream()` for this which is a get/setter - call with a sequence of data
and this pushes the values onto the stream. Call it without and it
returns the first value of the stream OR dies.

`stream_average` just pulls the next value from the stream (or dies)
and computes the average -- updates total(`$t`) and count(`$n`) -- and
returns the `$t`/`$n`

```perl
stream( map {$_*10} 1..50 ); ## Push values into stream...

eval {say stream_average();} until $@;

sub stream {
  state(@stream);
    @_      ? (push @stream,@_)
  : @stream ? shift @stream
  :           die;
}

sub stream_average {
  state($n,$t);
  return ($t+=stream) / ++$n;
 }

```

# Task 2 - Basketball Points

***You are given a score `$S`. You can win basketball points e.g. 1 point, 2 points and 3 points. Write a script to find out the different ways you can score `$S`..***

## Solution.

To get the combinations for a give number - we can shoot a 1, 2 or 3 point shot and then reconsider the combinations for the remaining point.

This leads us to a simple recursive solution.

```perl
sub pts {
  return $cache{$_[0]} ||= $_[0] < 1 ? [] : [
     map( {'1'.$_} @{pts( $_[0] - 1 )} ),
     map( {'2'.$_} @{pts( $_[0] - 2 )} ),
     map( {'3'.$_} @{pts( $_[0] - 3 )} )
  ];
}
```

**Note** To reduce complexity we pre-populate the cache for the first three cases:

 1. "1"
 2. "11" & "2"
 3. "111", "12", "21" and "3"

