[< Previous 212](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-212/james-smith) |
[Next 214 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-214/james-smith)

# The Weekly Challenge 213

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-214/james-smith

# Task 1:  Fun Sort

***You are given a list of positive integers. Write a script to sort the all even integers first then all odds in ascending order.***

## Solution

```perl
sub fun_sort {
  sort { $a%2 <=> $b%2 || $a <=> $b } @_
}
```

This was a simple challenge this week - firstly to sort odd from even we look at the last bit of the string - if even it is `0`, if odd `1`. So to get the even numbers before the odds we just sort on `$a%2 <=> $b%2` - we complete the sort by then sorting numerically.

This is faster than splitting the numbers into two lists and sorting separately and recombining... and much shorter.

# Task 2: Shortest Route

***You are given a list of bidirectional routes defining a network of nodes, as well as source and destination node numbers. Write a script to find the route from source to destination that passes through fewest nodes.***

## Solution

We use a graph walking algorithm. We start by generating a graph of all the nodes in the tree storing their neighbours.

We then need to try out all paths.

Note in this solution we walk backwards (this is due to the golf trick in line which creates the initial queue element as
a wrapper round the end node - can't do this with the start node as `my(@q,$e)` would put all values in `@q`.

So we start with a list of length 0 ($e), we then look to all neighbough's and compute the lists of length for the neighbours 1. At any point if we reach the start node then we return the list.

The nice thing with this solution is that the code is `O(n^2)`

```perl
sub shortest_route {
  my( $s, @q, %n, %d ) = ( shift, [my $e = shift] );    ## Get start end, and initialize queue
  return $s if $s eq $e;                                ## special case - as the soln only
                                                        ## returns list of length 1 or more
  for my $r (@_) {                                      ## Compute neighbour map.
    $n{ $r->[$_-1] }{ $r->[$_]   } =                    ## We need to walk both ways along the
    $n{ $r->[$_]   }{ $r->[$_-1] } = 1 for 1..$#$r;     ## route - so we start from the 2nd
  }                                                     ## so we don't fall off the LH end
  while( my $p = shift @q ) {                           ## For each queue
    $d{$p->[0]}=1;                                      ## mark element as seen..
    $_ eq $s ? return ($_,@{$p}) : $push @q, [$_,@{$p}] ## For each new node. If it is the
      for grep{ !$d{$_} } keys %{$n{$p->[0]}};          ## start we return the list, o/w push
  }                                                     ## it to the find all neighbours of
                                                        ## the current point we haven't
                                                        ## already seen 
  ()                                                    ## Empty list - as no route
}
```
