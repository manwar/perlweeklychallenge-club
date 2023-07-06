# Sieves and Coins
**Challenge 223 solutions in Perl by Matthias Muth**

## Task 1: Count Primes

> You are given a positive integer, $n.<br/>
> Write a script to find the total count of primes less than or equal to the given integer.<br/>

This looks very straightforward: get an array of prime numbers and return its length.<br/>
The only question is how to get the prime numbers between 2 and *n*.

If the number *n* is not too high, the '[Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)'
is a fairly simple and easy to implement algorithm to find prime numbers up to a limit *n*.<br/>
Its advantage is that it does not need any divisions,
and it has a runtime complexity of *O*( *n* log log *n* ),
which probably makes it faster than using a prime factorization for each candidate number.

Only if `n` gets larger it can run into memory issues.
But we are talking about *very* large numbers here,
since we are only limited by the RAM available for running our program,
and the RAM usage rises linearly with *n*
(one integer for each added number checked,
which might even be reduced to one *bit* per number).<br/>
So let's not worry too much about it,
also knowing that the challenge examples are up to *n* = 20 only.

The big advantage for us is that it computes and returns
the whole set of prime numbers up to *n*.
All that is left to do is to count them!

So here we go:

```perl
use strict;
use warnings;
use feature 'say';
use feature 'signatures';
no warnings 'experimental::signatures';

use lib '.';
use TestExtractor;

use List::Util qw( first );

sub eratosthenes( $n ) {
    my @non_primes;
    my $sqrt = sqrt( $n );
    my $i = 2;
    while ( $i <= $sqrt ) {
        say "trying $i:";
        for ( my $j = 2 * $i; $j <= $n; $j += $i ) {
            say "    mark $j as non-prime";
            $non_primes[$j] = 1;
        }
        $i = first { ! $non_primes[$_] } $i + 1 .. $n;
        say "    next \$i to try: $i";
    }
    say "    $i is larger than sqrt( $n ) ($sqrt)";
    say "returning ( ", join( " ", grep { ! $non_primes[$_] } 2..$n ), " )";
    return grep { ! $non_primes[$_] } 2..$n;
}

eratosthenes( 20 );
```

which prints
```
$ ch-1.pl
trying 2:
    mark 4 as non-prime
    mark 6 as non-prime
    mark 8 as non-prime
    mark 10 as non-prime
    mark 12 as non-prime
    mark 14 as non-prime
    mark 16 as non-prime
    mark 18 as non-prime
    mark 20 as non-prime
    next $i to try: 3
trying 3:
    mark 6 as non-prime
    mark 9 as non-prime
    mark 12 as non-prime
    mark 15 as non-prime
    mark 18 as non-prime
    next $i to try: 5
    5 is larger than sqrt( 20 ) (4.47213595499958)
returning ( 2 3 5 7 11 13 17 19 )
```

Then the actual solution to the task is this little function:
```perl
sub count_primes( $n ) {
    return scalar eratosthenes( $n );
}
```

## Task 2: Box Coins

> You are given an array representing box coins, @box.<br/>
> Write a script to collect the maximum coins until you took out all boxes.
> If we pick box[i] then we collect the coins $box[i-1] * $box[i] * $box[i+1].
> If $box[i+1] or $box[i-1] is out of bound then treat it as 1 coin.<br/>
> <br/>
> Example 1:<br/>
> Input: @box = (3, 1, 5, 8)<br/>
> Output: 167<br/>
> Step 1: pick box [i=1] and collected coins 3 * 1 * 5 => 15.  Boxes available (3, 5, 8).<br/>
> Step 2: pick box [i=1] and collected coins 3 * 5 * 8 => 120. Boxes available (3, 8).<br/>
> Step 3: pick box [i=0] and collected coins 1 * 3 * 8 => 24.  Boxes available (8).<br/>
> Step 4: pick box [i=0] and collected coins 1 * 8 * 1 => 8.   No more box available.<br/>
> <br/>
> Example 2:<br/>
> Input: @box = (1, 5)<br/>
> Output: 10<br/>
> Step 1: pick box [i=0] and collected coins 1 * 1 * 5 => 5. Boxes available (5).<br/>
> Step 2: pick box [i=0] and collected coins 1 * 5 * 1 => 5. No more box available.<br/>

We need to find out with which box to start.
It is the one that delivers the highest sum from taking this coin
*and* from finding the highest number possible from taking the rest of the coins in the right order.

A typical scenario for a recursive solution!

The stop condition is met when there is ony one coin.
Then it's obvious which one to take.

If there is more than one coin, we use a `map` call
to compute the maximum achievable value for all coins,
just as described:
multiply the coin with its neighbors (if they exist),
and do the recursive call for all coins but the current one.<br/>

And of course we return the maximum of this list.

```perl
sub box_coins {
    my ( @box ) = @_;

    return $box[0]
        if @box == 1;

    return max( map {
        ( $box[$_]
            * ( $_ > 0     ? $box[ $_ - 1 ] : 1 )
            * ( $_ < $#box ? $box[ $_ + 1 ] : 1 ) )
        + box_coins( @box[ 0 .. $_ - 1, $_ + 1 .. $#box ] );
    } 0..$#box );
}
```

#### **Thank you for the challenge!**
