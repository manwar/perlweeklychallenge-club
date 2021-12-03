# Perl Weekly Challenge #141

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-141/james-smith/perl

# Challenge 1 - Number Divisors

***Write a script to find lowest 10 positive integers having exactly 8 divisors.***

## The solution

For a number 2 have exactly 8 divisors it must be of the form:

 * `p1 * p2 * p3`
 * `p1 * p2^3`
 * `p1^8`

So to find the list of integers with 8 divisors we can generate a list of such numbers (for a set of small primes) and take the lowest 10...

So the code is written as 

```perl
my @primes = (2,3,5,7,11,13);
my @vals;

while(@primes) {
  push @vals, (my $p1 = shift @primes) ** 8;
  my @t  = @primes;
  while( @t ) {
    my $p2 = shift @t;
    push @vals, $p1*$p2**3, $p2*$p1**3, map {$p1*$p2*$_} @t;
  }
}

say for (sort{$a<=>$b}@vals)[0..9];
```

The `shift` operator on both `@primes` and `@t` means we don't get duplicate values (`$p1`<`$p2`<`$_`), but does mean that we have to find `p1 * p2^3` and `p1^3 * p2`.

As someone pointed out last week on Perl Programmers Facebook group `say` without any parameters operates on `$_` so the printing for loop simplifies to `say for ...`;


# Challenge 2 - Like Numbers

***You are given positive integers, `$m` and `$n`. Write a script to find total count of integers created using the digits of `$m` which is also divisible by `$n`. Repeating of digits are not allowed. Order/Sequence of digits can’t be altered. You are only allowed to use (n-1) digits at the most. For example, 432 is not acceptable integer created using the digits of 1234. Also for 1234, you can only have integers having no more than three digits.***

## The solution

The solution is here... but as it's so compact let us expand out the stages. Note as these are nested functions we will need to work backwards through the statement.
```perl
sub like_numbers {
  my @digits = split//,$_[0];
  0 + grep { !($_%$_[1]) }
       map { my $n=$_<<1; join '',grep{($n>>=1)&1} @digits }
           1 .. (1<<@digits) - 2
}
```

(line 1) The first thing we do is convert the number into an array of digits.

(line 4) We can enumarate the numbers made of the digits (in order) from `1` to `2^n-1` - the last though is the full number to so we reduce the loop to `1` to `2^n-2`.

(line 3) We use the binary representation of this number to work out which digits to use. Here we use the right shift operator (with `&1` to check to see if the digit is to be included. We have to do `$n=$_<<1;` in the map as the first thing we do is `$n>>=1`.

(line 2) We filter out numbers not divisible by `$n` using `grep`. We could use the `scalar` to explicitly cast the list to it's length or we can use the shorter 0+ which does it implicitly.
