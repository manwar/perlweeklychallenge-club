[< Previous 200](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-200/james-smith) |
[Next 202 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-202/james-smith)

# The Weekly Challenge 201

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-201/james-smith

# Task 1: Missing Numbers

***You are given an array of unique numbers. Write a script to find out all missing numbers in the range 0..$n where $n is the array size.***

## Solution

First we note for the problem as defined there will only ever be one missing number.

Second we note if we add the numbers up we have a total of `n(n+1)/2 - {missing number}`.

This leads us to two quite compact solutions:

```perl
sub missing { my $t = @_*(@_+1)/2; $t-=$_ for @_; $t }
sub missing_sum { @_*(@_+1)/2 - sum0 @_ }
```

Where we take `sum0` from `List::Util`.

### Performance

We compared the two methods - in each case the `sum0` solution was faster - we will come back to this in task 2!

What was interesting was relativee performance *vs* size of list. For short lists, the gain was a modest 25-30%, for medium size lists about 1,000 - 10,000 the gain was around 350%, but for larger lists again 100,000+ this dropped back down to 150-160%. This is probably the overhead of passing arrays around.

# Task 2: Penny Piles

***You are given an integer, `$n > 0`. Write a script to determine the number of ways of putting `$n` pennies in a row of piles of ascending heights from left to right.***

## Solution

This is a simple recursive search at any point we have `n` coins which we have to layout with a maximum height of `m` - we start where `m` is equal `n`.

For performance sake we will cache our results as there are lots of cache hits!.

So if `n` is 0 then we have found a solution - so we count 1, otherwise we make each possible sized pile and pass back to the function....

This gives us:

```perl
sub piles {
  my($count,$n,$m)=(0,@_);
  return 1 unless $n;                                ## We have found *A* solution
  $m//=$n;                                           ## First time we don't pass in $m -
                                                     ## so set it to $n
  return $cache{"$n,$m"} if exists $cache{"$n,$m"};  ## If we have seen this combo return
  $count += piles($n-$_,$_) for 1 .. ($m>$n?$n:$m);  ## Otherwise loop through possible coin
                                                     ## counts and add a stack of that size
                                                     ## this is limited by (a) the number of
                                                     ## coins and (b) the height of the
                                                     ## previous stack.
  $cache{"$n,$m"} ||= $count;                        ## cache result and return
}
```

Now we always like to simplify things - and in this case we return a cache value if
exists AND then compute the value and cache it - and return the cache value.

This is because we have to run a for loop to do the sum. If we can avoid that then we
can simplify the code...

Method (1) We replace the summation by a second function which encapsulates that 
value.

Method (2) We use `sum0` from `List::Util`
```perl
sub piles_2 {
  my($count,$n,$m)=(0,@_);
  return 1 unless $n;
  $m//=$n;
  $cache{"$n,$m"}//= sum_piles_2( $n, $m );
}

sub sum_piles_2 {
  my $count = 0;
  $count += piles_2($_[0]-$_,$_) for 1 .. ($_[1]>$_[0]?$_[0]:$_[1]);
  $count;
}

sub piles_0 {
  return 1 unless $_[0];
  $_[1]//=$_[0];
  $cache{"@_"}//= sum0 map { piles_0( $_[0]-$_,$_ ) } 1 .. ($_[0]>$_[1]?$_[1]:$_[0]);
}
```

Finally we try a further method without recursion but using a stack. Now this is much
harder to write - and also impossible to write a sensible cacheing algorithm for. We
will see that this is a bad idea in a moment:

```perl
sub piles_q {
  my($count,$n,@q,$v)=(0,$_[0],[1,$_[0]]);
  while($v = shift @q) {
    $count++ if $v->[1]>=$v->[0];
    push @q, map { [$_,$v->[1]-$_] } $v->[0]..$v->[1]-1;
  }
  $count;
}
```

### Performance

We got some results we didn't expect! So for our test sets (`$n` ranging from 5 to 50) we got:

| method     | runs per s  | Rel performance |
| :--------- |  ---------: | --------------: |
| piles_q    | 0.482/s     |         0.002 x |
| piles_0    |   253/s     |         0.842 x |
| piles      |   301/s     |         1.000 x |
| piles_2    |   326/s     |         1.114 x |

We note that the queue method is difficult to write and optimal solution for... But the other three methods we get subtly different performances.

Although in task 1 using `sum0` was better than not this time it's worse. Why is this? not sure - but it may be that in task 1 we summing an actual array but in this
case we are summing a list {the result of the `map`}. The two function method `piles_2` was slightly faster - I think because of merging the test for existance and allocation of the value to the cache using `//=`.
