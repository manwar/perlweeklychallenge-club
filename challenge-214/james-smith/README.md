[< Previous 213](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-213/james-smith) |
[Next 215 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-215/james-smith)

# The Weekly Challenge 214 - Another one rides the bus!

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-214/james-smith

# TASK #1: Rank Score

***You are given a list of scores (>=1). Write a script to rank each score in descending order. First three will get medals i.e. G (Gold), S (Silver) and B (Bronze). Rest will just get the ranking number.***

## Solution

```perl
sub rank {
  map { ['','G','S','B']->[$_] || $_ }
  map { //; 1 + grep { $_ > $' } @_ }
  @_
}
```

Simple solution we get the rank for each value by counting the number of elements greater than it and then coverting 1,2,3 to GSB

## Complex solution

```perl
sub rank2 {
  my $pos=0;
  @_ = sort { $b->[0] <=> $a->[0] }
       map  { [$_,$pos++,1]       }
            @_;
  $_[$_][2] = $_[$_][0] == $_[$_-1][0]
            ? $_[$_-1][2]
            : $_ + 1                   for 1..$#_;
  map  {  ['','G','S','B']->[$_->[2]] || $_->[2] }
  sort { $a->[1] <=> $b->[1]                     }
       @_
}
```

# TASK #2: Collect Points

***You are given a list of numbers. You will perform a series of removal operations. For each operation, you remove from the list N (one or more) equal and consecutive numbers, and add to your score N × N. Determine the maximum possible score.***

## Solution

A brute force approach is best here - we look for sequences of digits - remove from the list and add the "collect" call on the list with the sequence removed.. And we collect the best score

```perl
sub collect_cache {   ## We will use recursion here. we take out each number in
                      ## turn and pass it back to the function
  return 0 unless @_;                         ## The score for an empty list is 0
  my $m = 0;                                  ## Create a variable for the max value
  for ( my $e = my $o = 0; $o<@_; ) {         ## Loop from start to finish - 
                                              ## there is no inc as the $o = $e at
                                              ## the does the same think
    my $e = $o;                               ## Reset the end of the list to the start
    $e++ while $_[$o]==$_[$e];                ## Increment until we get to a different value
    sub { $m=$_[0] if $m<$_[0] }->(           ## Use and IIFE to collect max value
      ($e-$o)**2 +                            ## Add square of elements to value 
      collect( @_[ 0..$o-1, $e..$#_ ]         ## for the reduced list
    ), $o = $e; 
  }
  $m;
}


```
