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

We effectively use a modified schwartzian transform. But instead of computing one index and sorting by it we then use  2nd index and sort by it.

 * Add to each element and attribute which is additional position & a second which is going to be used for rank {we initialise as 1};
 * Sort based on value so highest is first;
 * Set the rank column - based on order;
   * The first rank is 1 - subsequent ranks are the position in the list if different from the previous number OR the rank of the previous number.
 * Sort again but this time on original position
   * to put numbers back where they were;
 * Finally extract the rank from the triple and map 1,2,3 to G,S,B

# TASK #2: Collect Points

***You are given a list of numbers. You will perform a series of removal operations. For each operation, you remove from the list N (one or more) equal and consecutive numbers, and add to your score N × N. Determine the maximum possible score.***

## Solution

A brute force approach is the easiet here - we look for sequences of digits - remove from the list and add the "collect" call on the list with the sequence removed.. And we collect the best score. But this is not particularly fast especially as the list grows.

```perl
sub collect {   ## We will use recursion here. we take out each number in
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

## Cacheing

By simply caching the result we can get a significant improvement in the examples we see around a 20-25x improvement, better improvements happen with larger examples, until at some point the cache will start eating into swap.. And things will tail off dramatically!

```perl
sub collect {   ## We will use recursion here. we take out each number in
                ## turn and pass it back to the function
  return 0 unless @_;                         ## The score for an empty list is 0
  my $k = "@_";                               ##+++  Generate key for cache
  return $cache->{$k} if exists $cache->{$k}; ##+++  Return cache value if exists
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
  $cache->{$k} = $m                           ##+++  Cache value & return
}
```

## Improving the algorithm

Here we work out a minimum best score - removing all numbers except for the most frequent and that leaves us with the best score of `f * f + ( n - f)`.
We also at each stage work out the possible maximum score - this is `score + sum(f*f)` over the remaining frequences. If this is lower than the
current max score we do not progress any futher...

```perl
sub _collect_fast {
  my $s = shift;
  return $s unless @_;  ## Empty list return score
  
  ## same digits.
  for ( my $e = my $o = 0; $o<@_; ) { ## We loop through
    my $e = $o;                ## the list for each                                    
    $e++ while $_[$o]==$_[$e]; ## sequence of same no.

    ## Compute the score so far $s + length of seq^2
    ## Compute max poss. score this + sum of squared
    ## counts of other number frequencies

    my $ms = my $ts = $s + ($e-$o)**2;
    my %f = ($_[$o] => $o-$e);
    $f{$_}++ for @_;
    $ms += $_ ** 2 for values %f;

    ## If the max possible score is > $m we compute
    ## actual score and update max if > $m

    if($ms>$m) {
      $ts = _collect_fast( $ts, @_[ 0..$o-1, $e..$#_ ] );
      ## And if it is greater than $m we update $m
      $m = $ts if $ts > $m;
    }
    $o = $e;
  }
}

sub collect_fast {
  return 0 unless @_;
  my %f;
  $m=0;
  $f{$_}++ for @_;                  ## compute freq
  $_>$m && ( $m=$_ ) for values %f; ## find largest
  $m = $m*$m + @_-$m;  ## Compute minimum-maximum
                       ## square of max freq -
                       ## count of remaining
  _collect_fast(0,@_); ## Now do the real work
  $m                   ## Return max (global variable)
}
```
