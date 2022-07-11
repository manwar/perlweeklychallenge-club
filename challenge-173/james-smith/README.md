[< Previous 172](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-172/james-smith) |
[Next 174 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-174/james-smith)

# The Weekly Challenge 173

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-173/james-smith

# Task 1 - Esthetic Number

***You are given a positive integer, `$n`. Write a script to find out if the given number is Esthetic Number. An esthetic number is a positive integer where every adjacent digit differs from its neighbour by 1.***

## Solution

We split the number up into it's individual digits. We then compare each digit with the previous one, if they are `+1` or `-1` we then update the "last" digit and repeat otherwise we short cut the loop and return 0.

```perl
sub is_esthetic {
  my($f,@n) = split //, shift;
  ( $_ == $f+1 || $_ == $f-1 ) ? ($f=$_) : return 0 for @n;
  1;
}
```

# Task 2 - Sylvester’s sequence

***Write a script to generate first 10 members of Sylvester's sequence. For each member of the sequence the value is equal to the product of previous terms + 1***

## Solution

We note that `S(n)` is the product of all prior terms plus 1, and so `S(n-1)` is similar. So this gives us that `S(n+1) = S(n)*( S(n) - 1 ) + 1`.

This reduces our problem considerably and we have the following code. To get the values our for `n` bigger than 7 we have to resort the the `bigint` directive.

```perl
my $n =2,
my @list = ( 2, map { $n = $n*($n-1) + 1 } 2..10 );
```
