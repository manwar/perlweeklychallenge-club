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

```perl
sub fibnum {
  my ( $r, $s ) = @_;
  ( $r, $s ) = ( $s, $r.$s ) while 51 > length $s;
  substr $s, 50, 1;
}
```

A slightly more compact version is achieved by:

 * Using `$a`, `$b` instead of `$r`, `$s`. The former are special variables (for sort) and therefore they don't have to be `my`ed even when strict is enabled.
 * By rewriting `( $r, $s ) = ( $s, $r.$s )` as the slightly less readable `$s = $r.( $r=$s )` here you have to realise that `$r` has the old value outside the brackets, and the new value (or `$s`) inside the brackets. So even though it looks like `$r.$r` it is infact `$r.$s`.

```perl
sub fibnum_messy {
  ($a,$b)=@_;$b=$a.($a=$b)while 51>length$b;substr$b,50,1;
}
```

# Challenge 2 - Square-free Integer

***Write a script to generate all square-free integers <= 500. In mathematics, a square-free integer (or squarefree integer) is an integer which is divisible by no perfect square other than 1. That is, its prime factorization has exactly one factor for each prime that appears in it. For example, 10 = 2 x 5 is square-free, but 18 = 2 x 3 x 3 is not, because 18 is divisible by 9 = 3**2

## The solution

```perl
my($N,@p2) = (@ARGV?$ARGV[0]:500,4);

for(my$c=3;$c*$c<$N;$c+=2){
  ($_>$c)?((push@p2,$c*$c),last):$c*$c%$_||last for@p2;
}

say for grep{my$t=$_;!grep{!($t%$_)}@p2}1..$N;
```
