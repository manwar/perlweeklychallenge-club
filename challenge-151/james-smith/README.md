[< Previous 149](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-149/james-smith) |
[Next 151 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-151/james-smith)
# Perl Weekly Challenge #150

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-150/james-smith

# Challenge 1 - Fibonacci Words

***You are given two strings having same number of digits, $a and $b. Write a script to generate Fibonacci Words by concatenation of the previous two strings. Finally print 51st digit of the first term having at least 51 digits.***

## The solution

As we are not interested in the full 'fibonnaci' sequence - we just need to keep the last two entries.

We use Perl's ability to update two variables at once with the line `( $r, $s ) = ( $s, $r.$s )` which means that the original `$r` is used in the evaluation of `$s` which is often very useful. We repeat this until the last string is long enough to find the 51st element.

We then just use `substr` to extract it (remembering `substr` is `0`-based so we only need character `50`.)

```perl
sub fibnum {
  my ( $r, $s ) = @_;
  ( $r, $s ) = ( $s, $r.$s ) while 51 > length $s;
  substr $s, 50, 1;
}
```

A slightly more compact version is achieved by:
 * By rewriting `( $r, $s ) = ( $s, $r.$s )` as the slightly less readable `$s = $r.( $r=$s )` here you have to realise that `$r` has the old value outside the brackets, and the new value (or `$s`) inside the brackets. So even though it looks like `$r.$r` it is infact `$r.$s`. Yargh!!
 * Using `$a`, `$b` instead of `$r`, `$s`. The former are *special* variables (for the comparision function in `sort`) and therefore they don't have to be `my`ed even when strict mode is enabled.

```perl
sub fibnum_messy {
  ($a,$b)=@_;$b=$a.($a=$b)while 51>length$b;
  substr$b,50,1;
}
```

# Challenge 2 - Square-free Integer

***Write a script to generate all square-free integers <= 500. In mathematics, a square-free integer (or squarefree integer) is an integer which is divisible by no perfect square other than 1. That is, its prime factorization has exactly one factor for each prime that appears in it. For example, 10 = 2 x 5 is square-free, but 18 = 2 x 3 x 3 is not, because 18 is divisible by 9 = 3**2

## The solution

Rather than searching for all square factors, we realise that we only need to search for the squares of primes {e.g. a number which is a multiple of `36=6*6` is also a multiple of both `4=2*2` and `9=3*3`.

So we do passes first we create a list of prime squares. Again we use our *nasty* 2 line "prime" generator. Except this time we store and check against `prime^2` rather than just prime.

**Note** we do the extra work of getting the square of the primes, rather than just the primes themselves, here. We do the "squaring operation" once only - and not every time through the second loop from `1..$N`.

The second pass (OK in compact form - may not be the most efficient as `$N` gets large) is a set of nested greps. The inner one returns an empty list if there are is a prime squared factor - and so negating it returns true.

```perl
my($N,@p2) = (@ARGV?$ARGV[0]:500,4);

for(my$c=3;$c*$c<$N;$c+=2){
  ($_>$c)?((push@p2,$c*$c),last):$c*$c%$_||last for@p2;
}

say for grep{my$t=$_;!grep{!($t%$_)}@p2}1..$N;
```

**Note** `say` without any parameters - outputs the contents of `$_` and then sends a carriage return. so `say for @A;` outputs all elements of the array `@A` on separate lines.

## Follow up

We can re-write the inefficient double `grep` more elegantly with nested `for`*each* loops. The new code becomes:

```perl
my ( $N, @p2 ) = ( @ARGV ? $ARGV[0] : 500 , 4 );

P: for ( my $c = 3; $c*$c <= $N; $c += 2 ) {
  $_ > $c  ? last : $c*$c % $_ || next P for @p2;
  push @p2, $c*$c;
}

O: for my $t ( 1 .. $N ) {
  $_ > $t  ? last :    $t % $_ || next O for @p2;
  say  $t;
}
```

### Notes:
 * We optimize the inner loop by allowing it to finish early if:
    * We have a prime^2 value greater than `$t`
    * We have a square factor

 * The difference in these two cases are:
    * We end the inner loop and output the number as a square-free int (`last`)
    * We skip to the next iteration of the outer loop (`next O`) without doing anything

 * The optimized version gives anywhere between 75% and 90% speed up... (values of `$N` between 100 and 1,000,000)

 * We have also re-written the prime generator to use the same `next {label}` trick, and this leads to a certain symmetry between the two loops. 
