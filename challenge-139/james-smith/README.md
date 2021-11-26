[< Previous 138](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-138/james-smith) |
[Next 140 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-140/james-smith)

# Perl Weekly Challenge #139 - "Whats recurring"

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-139/james-smith/perl

# Task 1 - JortSort

***You are given a list of numbers. Write a script to implement JortSort. It should return true/false depending if the given list of numbers are already sorted.***

## The solution

This challenge is relatively easy - to see if the list of numbers if monotonically increasing we just have to check that each entry is bigger than the one before.

* We start by shifting the first number of the list passed (this is the *previous number*);
* The loop through the rest comparing the current number against the previous number.
  * If the number is less than the previous number we return `0`;
  * Otherwise we set previous number `$p` to the current number and continue
* If we get to the end of the list then the list is sorted and we return `1`.

```perl
sub in_order {
  my $p = shift;
  ($p>$_) ? (return 0) : ($p=$_) for @_;
  return 1;
}
```

**Notes:**

* We can rewrite the `if( $x ) { y } else { z }` and `($x) ? (y) : (z)`. Why is this useful - well we can then use the brace less postfix `for` for the loop rather than having to use braces. This means the loop becomes 1 line, rather than the longer 7 line version using K&R braces. If you don't cuddle your braces it is even longer!

```perl
  for (@_) {
    if( $p>$_ ) {
      return 0;
    } else {
      $p = $_;  
    }
  }
```

Admittedly there is an intermediate version... That uses the exit early approach..

```perl
  for (@_) {
    return 0 if $p>$_;
    $p = $_;  
  }
```
that has only 4-lines.

# Task 2 - Long Primes

***Write a script to generate first 5 Long Primes. A prime number `p` is called Long Prime if `1/p` has an infinite decimal expansion repeating every `p-1` digits.***

## The solution

Now this challenge is not so easy - but those of us who have been working on the challenges for more than 6 months would have already worked out parts of fractions which are recursive. There were many solutions for this - if you didn't do the challenge.

You can see mine at: 

https://github.com/drbaggy/perlweeklychallenge-club/blob/master/challenge-106/james-smith/perl/ch-2.pl

Now we don't require the actual part of the number repeats which makes the function simpler, and we know explicitly that the numerator is going to be 1.

This gives us the function below to get the length of the recurring sequence.

```perl
sub rec_len {
  my( $D, $N, $s ) = ( shift, 1, '' );
  ( $s, $N ) = ( $s.int($N/$D), ($N%$D).0 ) for 0 .. 2*$D;
  $s =~ /(\d+?)\1+$/ ? length $1 : 0;
}
```

* We compute twice the number of digits than the denominator, we generate this as a string but using long-division to compute each digit.
* We then see if there is any repeating sequence (tied to the end of the sting we generate). We then get the length of this recurrent string. (If you don't include the `\1+` you could end up with a shorter match as "3333" would be picked up as "33" recurring rather than "3" recurring.

So now we have this function we can look at computing the long primes. We know that `1/2` doesn't recur so we can rule this out - that means we are only considering odd primes.

Therefore we loop through all the odd numbers checking to see if the number is a prime, if it is we then check for the property that the recurring sequence has `$p-1` digits.

```perl
my( $N, @primes, @long_primes ) = ( $ARGV[0]||5 );

O: for( my $p=3; @long_primes<$N; $p+=2 ) {
  ($p % $_) || (next O) for @primes;
  push @primes,      $p;
  push @long_primes, $p if $p - rec_len($p) == 1;
}
```
We will now break this down.
* The `for` line is obvious - repeat increasing `$p` by two until we have sufficient long primes.
* The next line loops through all current known primes to see if they are factor of `$p` - if yes skips to the next outer loop.
  * We use `next O` to jump out of the inner `for` loop, and to the start of the next outer `for` loop - labelled `O`.
  * We again use a trick to flatten the loop with a conditional: `($p % $_) || (next O)` if the first part is true the "or" `||` is true, so we don't evaluate the second part. But it `$_` is a factor of `$p` the left hand side is `0` (false) and so we need to evaluate it to see if the right hand side is true - and in the evaluation - skips to the start of the loop by executing `next O`.
* We know it has no known prime factors in line 3 so we add it to the list of primes.
* Then we use our `rec_len` function to see if the number is in fact a long prime.




