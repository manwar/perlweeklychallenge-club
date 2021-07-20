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

## Solution 2 - streaming

A caching/collecting solution always fails as the size of the data increases beyond the size of the memory of the machine. So we need to investigate
a streaming solution.

The first parameter is again the total we have to match. We keep track of the scores we have already seen and pass this as the 2nd parameter.
If we overshoot our total then the first parameter is less than 0 and we generate nothing or equal to run and display the sequence of points.

```perl
sub pts_streaming {
  return if  $_[0]<0;
  return say $_[1] unless $_[0];
  pts_streaming( $_[0]-$_, $_[1].$_ ) foreach 1..3;
}
```

There are a number of additional calls needed `$_[0] < 1`, we can optimize these out by using the pre-poulated part of the cache above.

```perl
sub pts_streaming_opt {
  return say "$_[1]1"                             if $_[0] == 1;
  return say "$_[1]11\n$_[1]2"                    if $_[0] == 2;
  return say "$_[1]111\n$_[1]12\n$_[1]21\n$_[1]3" if $_[0] == 3;
  pts_streaming_opt( $_[0]-$_, $_[1].$_ ) foreach 1..3;
}
```

If the score left is less than 4 we use the same pre-cache we had before to populate the values. This improves performance - for example for the
30 point solution we reduce the function calls from 192 million to 31 million and time taken from 3 minutes 20 seconds to just 55 seconds with this
simple tweak. This corresponds to an approximate reduction of 6.2 in function calls and about 3.5 reduction in time.

## Comparing solutions

By comparing timings on the 2G test machine we note that up to a score of 26 the caching solution is efficient [basically everything in memory] but
after this streaming solution is the only real option. The difference in time up to this point though is not that great. After we get past 27 the caching algorithm non-longer executes.

| `n` | calls cache | memory cache | time cache | calls stream | memory stream | time stream |
| --: | --: | --: | --: | --: | --: | --: |
|  5 | 7 | 9,208 | 0.010623 | 7 | 9,196 | 0.010567 |
| 10 | 22 | 9,204 | 0.010413 | 157 | 9,096 | 0.010751 |
| 15 | 37 | 10,488 | 0.015361 | 3,313 | 9,096 | 0.016229 |
| 20 | 52 | 38,916 | 0.117231 | 69,748 | 9,100 | 0.133544 |
| 25 | 67 | 645,680 | 2.371066 | 1,468,189 | 9,096 | 2.732431 |
| 26 | 70 | 1,183,636 | 4.619746 | 2,700,421 | 9,100 | 4.930112 |
| 27 | 73 | 2,176,060 | 23.422928 | 4,966,849 | 9,200 | 8.957511 |
| 28 | - | - | - | 9,135,460 | 9,096 | 16.605540 |
| 29 | - | - | - | 16,802,731 | 9,204 | 31.175462 |
| 30 | - | - | - | 30,905,041 | 9,200 | 61.526530 |



